wrk -t2 -c30 -d60s --latency https://entregis.herokuapp.com/v1/shipping_carriers
wrk -t2 -c30 -d60s --latency https://entregis.herokuapp.com/v1/shipping_carriers/1
wrk -t2 -c30 -d60s --latency https://entregis.herokuapp.com/v1/freights/7/search_carriers?sort=closest&page[size]=3

