 wire [6-1:0] in_part_fac_tor_a;
 wire [6-1:0] in_part_fac_tor_b;
 wire [6-1:0] out__z_prod_uct;
assign out__z_prod_uct[0] = 
 ((in_part_fac_tor_b[0] & ( 0  ^ in_part_fac_tor_a[0] ))) ^ 
 ((in_part_fac_tor_b[1] & ( 0  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[2] & ( 0  ^ in_part_fac_tor_a[4] ))) ^ 
 ((in_part_fac_tor_b[3] & ( 0  ^ in_part_fac_tor_a[3] ))) ^ 
 ((in_part_fac_tor_b[4] & ( 0  ^ in_part_fac_tor_a[2] ))) ^ 
 ((in_part_fac_tor_b[5] & ( 0  ^ in_part_fac_tor_a[1] ))) ^ 
0;
assign out__z_prod_uct[1] = 
 ((in_part_fac_tor_b[0] & ( 0  ^ in_part_fac_tor_a[1] ))) ^ 
 ((in_part_fac_tor_b[1] & ( 0  ^ in_part_fac_tor_a[0]  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[2] & ( 0  ^ in_part_fac_tor_a[4]  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[3] & ( 0  ^ in_part_fac_tor_a[3]  ^ in_part_fac_tor_a[4] ))) ^ 
 ((in_part_fac_tor_b[4] & ( 0  ^ in_part_fac_tor_a[2]  ^ in_part_fac_tor_a[3] ))) ^ 
 ((in_part_fac_tor_b[5] & ( 0  ^ in_part_fac_tor_a[1]  ^ in_part_fac_tor_a[2] ))) ^ 
0;
assign out__z_prod_uct[2] = 
 ((in_part_fac_tor_b[0] & ( 0  ^ in_part_fac_tor_a[2] ))) ^ 
 ((in_part_fac_tor_b[1] & ( 0  ^ in_part_fac_tor_a[1] ))) ^ 
 ((in_part_fac_tor_b[2] & ( 0  ^ in_part_fac_tor_a[0]  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[3] & ( 0  ^ in_part_fac_tor_a[4]  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[4] & ( 0  ^ in_part_fac_tor_a[3]  ^ in_part_fac_tor_a[4] ))) ^ 
 ((in_part_fac_tor_b[5] & ( 0  ^ in_part_fac_tor_a[2]  ^ in_part_fac_tor_a[3] ))) ^ 
0;
assign out__z_prod_uct[3] = 
 ((in_part_fac_tor_b[0] & ( 0  ^ in_part_fac_tor_a[3] ))) ^ 
 ((in_part_fac_tor_b[1] & ( 0  ^ in_part_fac_tor_a[2] ))) ^ 
 ((in_part_fac_tor_b[2] & ( 0  ^ in_part_fac_tor_a[1] ))) ^ 
 ((in_part_fac_tor_b[3] & ( 0  ^ in_part_fac_tor_a[0]  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[4] & ( 0  ^ in_part_fac_tor_a[4]  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[5] & ( 0  ^ in_part_fac_tor_a[3]  ^ in_part_fac_tor_a[4] ))) ^ 
0;
assign out__z_prod_uct[4] = 
 ((in_part_fac_tor_b[0] & ( 0  ^ in_part_fac_tor_a[4] ))) ^ 
 ((in_part_fac_tor_b[1] & ( 0  ^ in_part_fac_tor_a[3] ))) ^ 
 ((in_part_fac_tor_b[2] & ( 0  ^ in_part_fac_tor_a[2] ))) ^ 
 ((in_part_fac_tor_b[3] & ( 0  ^ in_part_fac_tor_a[1] ))) ^ 
 ((in_part_fac_tor_b[4] & ( 0  ^ in_part_fac_tor_a[0]  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[5] & ( 0  ^ in_part_fac_tor_a[4]  ^ in_part_fac_tor_a[5] ))) ^ 
0;
assign out__z_prod_uct[5] = 
 ((in_part_fac_tor_b[0] & ( 0  ^ in_part_fac_tor_a[5] ))) ^ 
 ((in_part_fac_tor_b[1] & ( 0  ^ in_part_fac_tor_a[4] ))) ^ 
 ((in_part_fac_tor_b[2] & ( 0  ^ in_part_fac_tor_a[3] ))) ^ 
 ((in_part_fac_tor_b[3] & ( 0  ^ in_part_fac_tor_a[2] ))) ^ 
 ((in_part_fac_tor_b[4] & ( 0  ^ in_part_fac_tor_a[1] ))) ^ 
 ((in_part_fac_tor_b[5] & ( 0  ^ in_part_fac_tor_a[0]  ^ in_part_fac_tor_a[5] ))) ^ 
0;
 assign in_part_fac_tor_b = fact_b;
 assign in_part_fac_tor_a = fact_a;
  assign prdct_z = out__z_prod_uct;
