select     
		   count(il2.invoice_id) count_of_invoices,
       cast(count(il2.invoice_id) as float) / ( select count(*) from  invoice) percent,
       case 
						when 
						(
								select t.track_id from track t 
								 where t.album_id = (select t2.album_id from  track t2 where t2.track_id = il2.first_track_id
																		) 
								except  
								select il3.track_id from invoice_line il3 where il2.invoice_id = il3.invoice_id
            ) is null 
						and (
                  select il3.track_id from invoice_line il3 where il3.invoice_id = il2.invoice_id
                  except  
                  select t.track_id from track t
                  where t.album_id = (select t2.album_id from track t2 where t2.track_id = il2.first_track_id
                                     ) 						
			      )	is null		
						then "Yes"
					  else "No"	
			 end as "album_purch"
			 
  from( 
				select il.invoice_id,
							 min(il.track_id) first_track_id
				from invoice_line il 
					 group by 1
       ) il2
			 group by album_purch
			 