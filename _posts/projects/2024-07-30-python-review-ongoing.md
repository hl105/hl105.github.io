---

title: "python review (ongoing)"
excerpt: "just some python review"
date: 2024-07-30
lastmod: 2024-07-30 22:04:23 -0400
last_modified_at: 2024-07-30 22:04:23 -0400
categories: project
tags: python
classes:
toc: true
toc_label:
toc_sticky: true
header:
    image:
    teaser:
    overlay_image: ./assets/images/banners/default.png
sitemap:
    changefreq: daily
    priority: 1.0
author:
---

### [decorators](https://www.geeksforgeeks.org/decorators-in-python/)

1. def: wrap another function to extend the behavior of the wrapped function w/o permanently modifying it
2. Python first class objects
	1. properties of [first class functions](https://www.geeksforgeeks.org/first-class-functions-python/):
		1. func is an instance of the Object type
		2. store the func in a variable
		3. pass the func as a parameter to another
		4. you can return the func from a func
		5. you can store funcs in data structures
	2. ex)

		```python
		def shout(text): 
		    return text.upper() 
		    
		# EXAMPLE 1
		yell = shout 
		print (yell('Hello')) # same as printing shout('Hello')
		
		def greet(func): 
		    # storing the function in a variable 
		    greeting = func("""Hi, I am created by a function 
		                    passed as an argument.""") 
		    print (greeting)  
		
		# EXAMPLE 2
		greet(shout) #returns all uppercase
		
		# EXAMPLE 3
		def create_adder(x): 
		    def adder(y): 
		        return x+y 
		  
		    return adder # returns a function
		
		add_15 = create_adder(15) # a func that adds 15
		print (add_15(10)) 
		```

3. Decorators
	1. functions are taken as the argument into another function and then called inside the wrapper function

	```python
	@gfg_decorator
	def hello_decorator():
	    print("Gfg") 
	    
	    
	# SAME AS   
	hello_decorator = gfg_decorator(hello_decorator)
	
	######################################
	
	# defining a decorator
	def hello_decorator(func):
	
	    def inner1(): # wrapper function
	    """
	    can access the outer functions (func)
	    """
	        print("Hello, this is before function execution")
	        func() # calling the actual function
	        print("This is after function execution")
	    return inner1
	
	# defining a function, to be called inside wrapper
	def function_to_be_used():
	
	    print("This is inside the function !!")
	 
	# passing 'function_to_be_used' inside the
	# decorator to control its behaviour
	function_to_be_used = hello_decorator(function_to_be_used)
	 
	function_to_be_used()
	
	######################################
	
	# importing libraries
	import time
	import math
	 
	# decorator to calculate duration taken by any function.
	def calculate_time(func):
	
	    def inner1(*args, **kwargs): #func takes any arguments
	    
	        # storing time before function execution
	        begin = time.time()
	         
	        func(*args, **kwargs)
	 
	        # storing time after function execution
	        end = time.time()
	        print("Total time taken in : ", func.__name__, end - begin)
	 
	    return inner1
	    
	# this can be added to any function present,
	# ex) calculating a factorial
	@calculate_time
	def factorial(num):
	    print(math.factorial(num))
	 
	# calling the function.
	factorial(10)
	
	"""
	3628800
	Total time taken in : factorial 0.0061802864074707
	"""
	
	
	######################################
	#What if a func returns something
	 
	@hello_decorator
	def sum_two_numbers(a, b):
	    print("Inside the function")
	    return a + b
	 
	a, b = 1, 2
	 
	# getting the value through return of the function
	print("Sum =", sum_two_numbers(a, b))
	
	"""
	before Execution
	Inside the function
	after Execution
	Sum = 3
	"""
	
	######################################
	#chaining decorators
	
	def decor1(func): 
	    def inner(): 
	        x = func() 
	        return x * x 
	    return inner 
	 
	def decor(func): 
	    def inner(): 
	        x = func() 
	        return 2 * x 
	    return inner 
	 
	@decor1
	@decor
	def num(): 
	    return 10
	   
	print(num()) #400 (from (2*10)*(20)). i.e.,  decor1(decor(num)))
	```
