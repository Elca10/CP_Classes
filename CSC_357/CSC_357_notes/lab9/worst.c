/*
MODIFICATION OF original.c
Searches for smallest free block available to satisfy request.
Requests additional memory only if there is no block large enough. 
*/

// From The C Programming Language, Kernighan and Ritchie
// Chapter 8, Section 7

#define _BSD_SOURCE
#include <stdio.h>
#include <unistd.h>

#include "mem.h"

typedef long Align;

// This defines the header for a "chunk" of memory within the heap.
// It uses a union type (which is something not generally discussed in
// CSC 357), but only to ensure that the memory is properly aligned on
// an address consistent with a long.
//
// The most important view of the header is that of a struct that
// represents a node in a linked list. The ptr within the struct
// can be used to point to the next "chunk" of memory in the free
// list (if this "chunk" is also in the free list). The size is used
// to track the amount of memory within this "chunk" (including the
// space for the header itself).
union header
{
   struct
   {
      union header *ptr;
      size_t size;
   } s;
   Align x;
};

typedef union header Header;

// The base variable is used to maintain the free list as a circular list.
static Header base;

// freep is a pointer into the free list.
static Header *freep = NULL;

// This is a forward declaration to a later function.
static Header *morecore(size_t);


// Here is one implementation of malloc. As with the standard malloc,
// this function takes the requested size (in bytes) and returns either
// NULL or a pointer to the allocated space.
void *lab_malloc(size_t nbytes)
{
   Header *p, *prevp;
   size_t nunits;
   // Initialize vars for tracking best fit
   Header *worst_fit = NULL;
   Header *prev_worst_fit = NULL;
   size_t largest_block_size = 0;
   


   // The size to request is converted to the number of Header units plus
   // one for the actual header. This means that for this implementation,
   // allocations are in multiples of the Header size.
   nunits = (nbytes + sizeof(Header) - 1)/ sizeof(Header) + 1;

   // Start prevp where freep is. If they are NULL, then initialize the base.
   if ((prevp = freep) == NULL)
   {
      // base points back to itself. freep and prevp point to the base.
      base.s.ptr = freep = prevp = &base;
      // base has a 0 size so that it will not be used to satisfy an
      // allocation request.
      base.s.size = 0;
   }

   // Use p to walk through the list by starting at the "node" after
   // prevp. Update prevp and p in lockstep (prevp follows p).
   //
   // Note, as well, that p is starting one node *after* freep since
   // prevp was initialized to freep.
   for (p = prevp->s.ptr; ; prevp = p, p = p->s.ptr)
   {
      // Is the node at p large enough to satisfy the request?
      // And is it a better fit than the current fit?
      if (p->s.size >= nunits && p->s.size > largest_block_size)
      {
         worst_fit = p;
         prev_worst_fit = prevp;
         largest_block_size = p->s.size;

         // We're just trying to find the smallest block right now, no need to carve
         // // Is it exactly the same size?
         // if (p->s.size == nunits)
         // {
         //    // Since the full node will be used, update prevp to "skip"
         //    // this node.
         //    prevp->s.ptr = p->s.ptr;
         // }
         // 
         // else
         // {
         //    // There is extra space, so "carve" some of it off.
         //    // Reduce the size of this node.
         //    p->s.size -= nunits;
         //    // Move p forward by that remaining size.
         //    p += p->s.size;
         //    // Set the size where p now points.
         //    p->s.size = nunits;

         //    // What did the above just do?
         //    // When "carving" a smaller piece from the larger "chunk",
         //    // from where was that smaller piece carved?
         // }

         // // Update freep to prevp for locality purposes.
         // freep = prevp;

         // // Return a pointer to the "chunk", but skipping the header.
         // return (void *)(p + 1);
      }

      // p is not large enough. Has the search cycled all the way back to
      // where it started? Recall that prevp was initialized to freep and
      // the block at p (freep if equal) is not large enough.
      if (p == freep)
      {
         // Now allocate from best fit block found
         if (worst_fit) {
            if (worst_fit->s.size == nunits) { // block is exact fit
               prev_worst_fit->s.ptr = worst_fit->s.ptr; // Best fit equivalent of code above
            } else { // there is extra space
               worst_fit->s.size -= nunits;
               worst_fit = worst_fit + worst_fit->s.size;
               worst_fit->s.size = nunits;
            }
            freep = prev_worst_fit;
            return (void *)(worst_fit + 1);
         }

         // The request cannot be satisfied by the current free list.
         // Request more space by calling morecore.
         if ((p = morecore(nunits)) == NULL)
         {
            // No space granted, the allocation request cannot be satisfied.
            return NULL;
         }
      }
   }
}

#define NALLOC 1024
// This function will request that the operating system allow the process
// (the executing program) to access more of the address space without checks.
static Header *morecore(size_t nu)
{
   char *cp;
   Header *up;

   // System calls (the sbrk below) are costly, so let's reduce the overall
   // cost by using a "reasonable" minimum size. If the call to morecore
   // requests less than this size, then increase it.
   if (nu < NALLOC)
   {
      nu = NALLOC;
   }


   // Please, OS, may I have some more please?
   // Use a system call to request that the access to the memory space be
   // extended.
   cp = sbrk(nu * sizeof(Header));

   if (cp == (char *) -1)
   {
      // The OS said no.
      return NULL;
   }

   up = (Header *) cp;
   // Set the size within this header.
   up->s.size = nu;

   // Free this space. This may seem peculiar. Why free it when it was
   // never actually allocated? As you will see below, all that free
   // really does is place a "chunk" into the free list.
   lab_free((void *)(up + 1));

   // Return the free pointer. What will this be after the call to lab_free()
   // on this fresh "chunk"? Where is that fresh chunk placed in the free
   // list? Will it be coalesced (see below) with a chunk before it?
   return freep;
}

void lab_free(void *ap)
{
   Header *bp, *p;

   // The header information is immediately before the space to be freed.
   // Or at least we assume it is. There is no way to tell. This is why
   // calling free() on a "wrong" pointer is so troublesome.
   bp = (Header *)ap - 1;

   // Where should we place the "chunk" being freed? It works well to
   // keep the free list in order by address. You will see why below.
   //
   // Loop until the bp address comes between the p "node" and the
   // "node" that follows p.
   for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
   {
      // If p is an address *after* the node that follows it (how?)
      // and bp comes after p or before that other node (what does this
      // mean?), then stop.
      if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      {
         break;
      }
   }

   // If the "chunk" starting at bp (and extending "size" units) ends
   // right where the "next" node starts, then these are contiguous.
   // Let's combine (coalesce) them into a single large "chunk".
   if (bp + bp->s.size == p->s.ptr)
   {
      // The total size of the coalesced "chunks".
      bp->s.size += p->s.ptr->s.size;
      // Partially link this "chunk" into the list (point it to the proper
      // node).
      bp->s.ptr = p->s.ptr->s.ptr;
   }
   else
   {
      // Partially link this "chunk" into the list (point it to the proper
      // node).
      bp->s.ptr = p->s.ptr;
   }

   // Another opportunity to coalesce (bp immediately follows p).
   if (p + p->s.size == bp)
   {
      // Update the size and fix the "next" pointer.
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
   }
   else
   {
      // Link to the newly freed "chunk".
      p->s.ptr = bp;
   }

   // freep is now p, which is either the coalesced node or the node
   // that points to the just freed space.
   freep = p;
}
