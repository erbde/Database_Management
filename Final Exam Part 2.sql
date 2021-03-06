---------------------------------------------------------
--         DAPT 611 Database Systems                   --
--             Final Exam Part 2                       --
--                Daniel Erb                           --
---------------------------------------------------------


---------------------------------------------------------
--         A                                           --
---------------------------------------------------------

-- Display the total cost of each raw material used in a product.
-- Each raw material cost is multiplied by the quantity required.

SELECT PRODUCT_T.PRODUCTID
,PRODUCT_T.PRODUCTSTANDARDPRICE
,RAWMATERIAL_T.MATERIALID
,RAWMATERIAL_T.MATERIALSTANDARDPRICE
,USES_T.QUANTITYREQUIRED
,RAWMATERIAL_T.MATERIALSTANDARDPRICE*USES_T.QUANTITYREQUIRED AS TOTALCOSTPERRAWMATERIAL
FROM PRODUCT_T
JOIN USES_T ON USES_T.PRODUCTID = PRODUCT_T.PRODUCTID
JOIN RAWMATERIAL_T ON RAWMATERIAL_T.MATERIALID = USES_T.MATERIALID
ORDER BY PRODUCT_T.PRODUCTID,PRODUCT_T.PRODUCTSTANDARDPRICE;

---------------------------------------------------------
--         B                                           --
---------------------------------------------------------

-- Display the standard price of each product 
-- and its total raw material cost

select product_t.productid
,product_t.productstandardprice as pstandardprice
,prod_cost.totalrawcostperproduct
from product_t
join 
  (
  SELECT 
  PRODUCT_T.PRODUCTID
  ,SUM(RAWMATERIAL_T.MATERIALSTANDARDPRICE*USES_T.QUANTITYREQUIRED) AS TOTALRAWCOSTPERPRODUCT
  FROM PRODUCT_T
  JOIN USES_T ON USES_T.PRODUCTID = PRODUCT_T.PRODUCTID
  JOIN RAWMATERIAL_T ON RAWMATERIAL_T.MATERIALID = USES_T.MATERIALID
  group by PRODUCT_T.PRODUCTID
  ) 
  prod_cost 
on prod_cost.productid = product_t.productid
;

---------------------------------------------------------
--         C                                           --
---------------------------------------------------------
-- Display the profit of each product.

select product_t.productid
,product_t.productstandardprice
,prod_cost.RAWCOST
,product_t.productstandardprice - prod_cost.rawcost as PROFIT
from product_t
join 
  (
  SELECT 
  PRODUCT_T.PRODUCTID
  ,SUM(RAWMATERIAL_T.MATERIALSTANDARDPRICE*USES_T.QUANTITYREQUIRED) AS RAWCOST
  FROM PRODUCT_T
  JOIN USES_T ON USES_T.PRODUCTID = PRODUCT_T.PRODUCTID
  JOIN RAWMATERIAL_T ON RAWMATERIAL_T.MATERIALID = USES_T.MATERIALID
  group by PRODUCT_T.PRODUCTID
  ) prod_cost 
on prod_cost.productid = product_t.productid
;

                                                                                                          
---------------------------------------------------------
--         D                                           --
---------------------------------------------------------
-- Display the raw material cost of each order.
                                                                                                         
select 
order_t.orderid
,sum(orderline_t.orderedquantity*prodrawcost.rawcost) totalmaterialcostofeachorder
from order_t
join orderline_t on orderline_t.orderid = order_t.orderid
join
  (
  SELECT PRODUCT_T.PRODUCTID
  ,SUM(RAWMATERIAL_T.MATERIALSTANDARDPRICE*USES_T.QUANTITYREQUIRED) AS RAWCOST
  FROM PRODUCT_T
  JOIN USES_T ON USES_T.PRODUCTID = PRODUCT_T.PRODUCTID
  JOIN RAWMATERIAL_T ON RAWMATERIAL_T.MATERIALID = USES_T.MATERIALID
  group by product_t.productid
  ) prodrawcost
on prodrawcost.productid = orderline_t.productid
group by order_t.orderid
order by orderid
;

                                                
---------------------------------------------------------
--         E                                           --
---------------------------------------------------------
                                                                                                          
select 
extract(month from orderdate) as month
,sum(productstandardprice*orderedquantity) as totalsales
from order_t
join orderline_t on orderline_t.orderid = order_t.orderid
join product_t on product_t.productid = orderline_t.productid
where orderdate between '04/01/2010' and '06/30/2010'
group by extract(month from orderdate)
order by month
;
