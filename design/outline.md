# Page 1

## Business

TCD Stocking Inc. 

restaurant food-item wholesaler in cali who gets a lot of product from east asia and latam

## Problem 

Need to track inventory and invoices robustly

## Solution

Use dbms 

# P 2

## Problem

* Order concurrency
* More than one distribution location
* Shipping costs tracking
* ROI calculations 
* Good records for taxes and accounting

## Contrain

* Regulatory contraints

## objective

* centralized source of truth
* data redundancy
* <all db benifits>
* detailed transaction history

# P3 - Scope and boundaries with business rules

## Scope

* 3 warehouses with different locations
* Each warehouse has some but not all products
* They each have a flat shipping cost
* They each have a flat import cost
* We have customers that can order more than one type of item with any count

## Business rules

* Each warehouse has an 0..n food item types
* Each food item has a catagory 
* Each order can be filled, not filled, or unable to be filled
* One customer can order many different items


Order flow story

     TCD stocking Inc. imports food from East Asia and Latin America. For each warehouse, we have a list of parts. For every item we have a restock point. Whenever a item crosses below the restock threshold, a warehouse manager restock the item. Customers can place orders. Customers can order many types of items at any count. When a order is fulfilled, it can come from many warehouses. Its possible to not have the stock to fulfull an order. We track items. We track import costs. We want to always sell at a profit. 

## pg4 - ERD

Food 
* Produce
  * Celery
  * Tomato
  * Spinach
* Meat
  * Lamb
  * Veal
    * Weinershnitzl
  * Beef
* Dairy
  * Milk
    * Almond milk
    * Oat milk
  * yogurt
  * butter
  * egg
* Bakery
  * Flour
  * Bread
    * Italian Bread
  * Flan
* Deli
  * Slammed-knees
  * Bologna
  * ham
* Frozen
  * Ice cream
  * Ice
  * shrimp
* Shelf-stable
  * crackers
  * tomato paste
  * condensed milk

