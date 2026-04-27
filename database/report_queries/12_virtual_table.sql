SELECT
    invoice_number,
    invoice_date,
    customer_name,
    subtotal,
    shipping_amount,
    tax_amount,
    invoice_total
FROM vw_order_totals
ORDER BY invoice_total DESC
LIMIT 10;
