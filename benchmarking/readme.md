# Benchmarking

The tests were made using [wrk](https://github.com/wg/wrk) in production (all dynos)

Just run at root app `./benchmarking/benchmark.sh`

## Specifications

Webserver specification:

| Dyno Type |	Memory (RAM) |	CPU Share |
|-----------|--------------|------------|
| free | 	512 MB           |	1x        |

Database specification:

| Dyno Type |	Memory (RAM) |	CPU Share |
|-----------|--------------|------------|
| free | 	512MB           |	1x        |

## Result

Request to -> https://entregis.herokuapp.com/v1/shipping_carriers
```
Running 1m test @ https://entregis.herokuapp.com/v1/shipping_carriers
  2 threads and 30 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   567.12ms  166.46ms   1.98s    84.46%
    Req/Sec    26.64     12.62    70.00     62.96%
  Latency Distribution
     50%  531.30ms
     75%  621.94ms
     90%  748.51ms
     99%    1.32s
  3088 requests in 1.00m, 4.04MB read
  Socket errors: connect 0, read 0, write 0, timeout 19
Requests/sec:     51.39
Transfer/sec:     68.81KB
```

Request to -> https://entregis.herokuapp.com/v1/shipping_carriers/1
```
Running 1m test @ https://entregis.herokuapp.com/v1/shipping_carriers/1
  2 threads and 30 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   241.08ms   58.39ms   1.30s    85.00%
    Req/Sec    61.75     19.40   120.00     71.06%
  Latency Distribution
     50%  231.16ms
     75%  260.73ms
     90%  299.35ms
     99%  408.45ms
  7307 requests in 1.00m, 2.88MB read
  Socket errors: connect 0, read 0, write 0, timeout 4
  Non-2xx or 3xx responses: 7307
Requests/sec:    121.62
Transfer/sec:     49.05KB
```

Request to -> https://entregis.herokuapp.com/v1/freights/7/search_carriers?sort=closest&page[size]=3
```
Running 1m test @ https://entregis.herokuapp.com/v1/freights/7/search_carriers?sort=closest&page[size]=3
  2 threads and 30 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   417.62ms   85.48ms   1.89s    81.49%
    Req/Sec    35.83     13.20    70.00     60.73%
  Latency Distribution
     50%  404.32ms
     75%  450.85ms
     90%  511.54ms
     99%  674.35ms
  4231 requests in 1.00m, 3.52MB read
  Socket errors: connect 0, read 0, write 0, timeout 3
Requests/sec:     70.43
Transfer/sec:     59.97KB
```

## Conclusion

After collecting the results and simple analytics on NewRelic, I just realized that the most problem is the requesting queue.
The NewRelic log indicates the API limit is aroud 2k RPM.
