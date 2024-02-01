# Example 1: Variables and Printing
name = "John"
age = 25
print("My name is", name, "and I am", age, "years old.")

# Example 2: Control Flow (If-Else)
temperature = 20

if temperature > 25:
    print("It's a hot day!")
else:
    print("It's not too hot today.")

# Example 3: Loops (For and While)
# For loop
for i in range(5):
    print("Iteration", i)

# While loop
counter = 0
while counter < 3:
    print("Count:", counter)
    counter += 1

# Example 4: Functions
def greet(name):
    return "Hello, " + name + "!"

print(greet("Alice"))

# Example 5: Lists
fruits = ["apple", "banana", "orange"]
print("First fruit:", fruits[0])

# Iterate through the list
for fruit in fruits:
    print(fruit)

# Example 6: Dictionaries
person = {"name": "Bob", "age": 30, "city": "New York"}
print("Name:", person["name"])


# Write to a file in the 'py' directory
with open("example.txt", "w") as file:
    file.write("Hello, Python!")

# Read from the file in the 'py' directory
with open("example.txt", "r") as file:
    content = file.read()
    print("File Content:", content)