select country_other,
       count(distinct customer_id) customers,
			 sum(unit_price) total_sales,
       sum(unit_price) / count(distinct customer_id) customer_lifetime_value,
       sum(unit_price) / count(distinct invoice_id) average_order,			 
			 case when country_other = "Other" then 1
						else 0
			 end as sort 
			 
  from (
					select c.customer_id,
								 c.country,
								 case 
										when (select count(*) from customer where country = c.country) = 1 then "Other"
										else c.country
								 end as country_other,
							 il.* 
						from invoice_line il 
						 inner join invoice inv on inv.invoice_id = il.invoice_id
						 inner join customer c on c.customer_id = inv.customer_id
     )
		 group by country_other
		 order by sort, country_other
		 