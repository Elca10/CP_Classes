class Flower:
# Common base class for all Flowers
    def __init__(self, petalName, petalNumber, petalPrice):
        self.name = petalName
        self.petals = petalNumber
        self.price = petalPrice

    def setName(self, petalName):
        self.name = petalName

    def setPetals(self, petalNumber):
        self.petals = petalNumber

    def setPrice(self, petalPrice):
        self.price = petalPrice

    def getName(self):
        return self.name
    
    def getPetals(self):
        return self.petals
    
    def getPrice(self):
        return self.price

#This would create first object of Flower class
f1 = Flower("Sunflower", 2, 1000)
print ("Flower Details:")
print ("Name: ", f1.getName())
print ("Number of petals:", f1.getPetals())
print ("Price:",f1.getPrice())
print ("\n")

#This would create second object of Flower class
f2 = Flower("Rose", 5, 2000)
f2.setPrice(3333)
f2.setPetals(6)
print ("Flower Details:")
print ("Name: ", f2.getName())
print ("Number of petals:", f2.getPetals())
print ("Price:",f2.getPrice())

# Final ouput: 2 instances of the Flower class
# First flower: Sunflower with 2 petals and price of 1000
# Second flower: rose with 6 petals and price of 3333


class Product:
    def __init__(self, productName, productAmount, productPrice, balance=1000) -> None:
        # initialize the relevant variables
        self.name = productName
        self.amount = productAmount
        self.price = productPrice
        # if balance is not inputted, default is 1000
        self.balance = balance

    def get_price(self, quantity:int):
        # return the price based on quantity being purchased
        if quantity > self.quantity:
            print(f"Not enough to completely fulfill order. Purchasing {self.quantity}/{quantity}")
        if quantity < 10:
            return self.price * quantity
        if quantity < 99:
            return 0.9 * self.price * quantity
        else:
            return 0.8 * self.price * quantity
        
    def make_purchase(self, quantity):
        #self.amount -= quantity
        if self.balance > quantity * self.price: # if you have enough
            self.balance -= quantity * self.price
        else:
            print("You don't have enough funds to make this purchase")

    
class Converter:
    def __init__(self, length, unit) -> None:
        self.length = length
        self.unit = unit
        self.to_inches = {'inches':1,'feet':12,'yards':36,'miles':63360,'kilometers':39370,'meters':39.37,'centimeters':1/2.54,'millimeters':1/25.4}
        self.from_inches = {'inches':1, 'feet':1/12, 'yards':1/36,'miles':1/63360,'kilometers':1/39370, 'meters':1/39.37,'centimeters':2.54,'millimeters':25.4}

    def inches(self):
        return self.length * self.to_inches[self.unit]

    def feet(self):
        length_in_inches = self.length * self.to_inches[self.unit]
        length_in_feet = length_in_inches * self.from_inches['feet']
        return length_in_feet
    
    def yards(self):
        return (self.length * self.to_inches[self.unit]) * self.from_inches['yards']
    
    def miles(self):
        return (self.length * self.to_inches[self.unit]) * self.from_inches['miles']
    
    def kilometers(self):
        return (self.length * self.to_inches[self.unit]) * self.from_inches['kilometers']
    
    def meters(self):
        return (self.length * self.to_inches[self.unit]) * self.from_inches['meters']
    
    def centimeters(self):
        s = self.length * self.to_inches[self.unit]
        return (self.length * self.to_inches[self.unit]) * self.from_inches['centimeters']
    
    def millimeters(self):
        return (self.length * self.to_inches[self.unit]) * self.from_inches['millimeters']


import unittest

class testProduct(unittest.TestCase):
    def test_get_price(self):
        shirt = Product("shirt", 20, 50)
        #self.assertEqual()

    def test_make_purchase(self):
        pass

class testConverter(unittest.TestCase):
    def test_inches(self):
        c = Converter(1,'feet')
        self.assertEqual(c.inches(), 12)

        d = Converter(12,'inches')
        self.assertEqual(d.inches(), 12)

    def test_yards(self):
        c = Converter(3,'feet')
        self.assertEqual(c.yards(), 1)

    def test_kilometers(self):
        c = Converter(1000,'meters')
        self.assertEqual(c.kilometers(), 1)


    # negative test cases --> values that can give you errors
    # boundary test cases, edge cases

    


if __name__ == '__main__':
    unittest.main()