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

SELECT PRODUCTID, PSTANDARDPRICE, TOTALRAWCOSTPERPRODUCT
FROM PRODUCT_T
JOIN USES_T ON USES_T.PRODUCTID = PRODUCT_T.PRODUCTID
JOIN RAWMATERIAL_T ON RAWMATERIAL_T.MATERIALID = USES_T.MATERIALID












