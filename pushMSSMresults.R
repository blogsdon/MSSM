require(synapseClient)
synapseLogin()

foo <- File('BM10_MEGENA_Network.txt',parentId='syn4907617')
foo <- synStore(foo)

foo <- File('BM10_MEGENA_modules.txt',parentId='syn4907617')
foo <- synStore(foo)

foo <- File('BM22_MEGENA_Network.txt',parentId='syn4907617')
foo <- synStore(foo)

foo <- File('BM22_MEGENA_modules.txt',parentId='syn4907617')
foo <- synStore(foo)

foo <- File('BM36_MEGENA_Network.txt',parentId='syn4907617')
foo <- synStore(foo)

foo <- File('BM36_MEGENA_modules.txt',parentId='syn4907617')
foo <- synStore(foo)
