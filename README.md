## Cats Dealer
### Main features
1) Easy to enable/disable provider(just change configuration)
2) Easy to add a new provider: add configuration, implement a new provider. No need to change existing code.
3) Can add new animals. Use `Store` with another configuration.
4) Performance boost with threads
Without threads: 1715ms, 1696ms
With threads: 1038ms, 841ms

### Possible next steps
1) Save dictionaries in DB
2) Maybe we can save cats data?(depends on the frequency of changes from the provider)
3) Background job for dictionaries/cats updating
4) Save configuration in DB. Can edit from admin
5) Hadle third party API failure
