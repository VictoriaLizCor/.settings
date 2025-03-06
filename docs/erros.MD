#0 building with "rootless" instance using docker driver

#1 [fastify internal] load build definition from Dockerfile
#1 transferring dockerfile:
#1 transferring dockerfile: 336B 0.0s done
#1 DONE 0.2s

#2 [traefik internal] load build definition from Dockerfile
#2 transferring dockerfile: 676B done
#2 DONE 0.2s

#3 [fastify internal] load metadata for docker.io/library/node:20-alpine
#3 ...

#4 [traefik internal] load metadata for docker.io/library/traefik:v3.3.3
#4 DONE 1.8s

#3 [fastify internal] load metadata for docker.io/library/node:20-alpine
#3 DONE 1.9s

#5 [traefik internal] load .dockerignore
#5 transferring context: 2B done
#5 DONE 0.1s

#6 [fastify internal] load .dockerignore
#6 transferring context: 248B done
#6 DONE 0.1s

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 resolve docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 ...

#8 [fastify internal] load build context
#8 transferring context: 1.82kB done
#8 DONE 0.1s

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 resolve docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea 0.2s done
#7 sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea 7.67kB / 7.67kB done
#7 sha256:ba8312129a193a1f1a781d93afcf6e641956d6e48e3ddefa9b64cd86790ee64c 1.72kB / 1.72kB done
#7 sha256:62dd47071da9b5f894d190944036caf6e5fad07d32f61c15f47d8ce7c03003d2 6.18kB / 6.18kB done
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 0B / 3.64MB 0.0s
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 0B / 3.64MB 5.0s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 resolve docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46 0.1s done
#9 sha256:14af895bf37700236e83b389baaa2353608be313ef771f1430159592d7d3537c 1.73kB / 1.73kB done
#9 sha256:e94799fce5142d1698aa5cd8f8e7d132bfcf3dfe66da9ddd85031903cfd40297 3.09kB / 3.09kB done
#9 sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46 7.71kB / 7.71kB done
#9 sha256:660f734330e488ab9aaa6fadf5f53a683376b1746ed6e941829076f5db4e7c0b 0B / 458.63kB 7.0s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 4.19MB / 48.22MB 7.0s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 0B / 3.64MB 10.2s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 7.34MB / 48.22MB 11.0s
#9 sha256:660f734330e488ab9aaa6fadf5f53a683376b1746ed6e941829076f5db4e7c0b 0B / 458.63kB 12.1s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 0B / 3.64MB 15.3s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 9.44MB / 48.22MB 16.0s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:660f734330e488ab9aaa6fadf5f53a683376b1746ed6e941829076f5db4e7c0b 0B / 458.63kB 17.2s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 0B / 3.64MB 20.3s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 10.49MB / 48.22MB 21.0s
#9 sha256:660f734330e488ab9aaa6fadf5f53a683376b1746ed6e941829076f5db4e7c0b 0B / 458.63kB 22.2s
#9 sha256:660f734330e488ab9aaa6fadf5f53a683376b1746ed6e941829076f5db4e7c0b 458.63kB / 458.63kB 23.5s done
#9 sha256:b6438ad7918fa97f72c113419bad1eba7588624de0c03eb4fed58cd65a20f73b 0B / 369B 23.6s
#9 sha256:b6438ad7918fa97f72c113419bad1eba7588624de0c03eb4fed58cd65a20f73b 369B / 369B 23.7s done
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 23.9s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 11.53MB / 48.22MB 26.0s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 1.05MB / 42.62MB 27.2s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 28.9s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 11.53MB / 48.22MB 31.2s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 34.0s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 11.53MB / 48.22MB 36.2s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 3.15MB / 42.62MB 37.4s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 39.2s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 11.53MB / 48.22MB 41.3s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 44.2s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 11.53MB / 48.22MB 46.4s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 3.15MB / 42.62MB 47.5s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 49.4s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 11.53MB / 48.22MB 51.5s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 54.4s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 11.53MB / 48.22MB 56.6s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 3.15MB / 42.62MB 57.7s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 59.5s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 13.63MB / 48.22MB 61.7s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 16.78MB / 48.22MB 63.6s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 64.6s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 3.15MB / 42.62MB 68.0s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 16.78MB / 48.22MB 68.6s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 69.7s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 16.78MB / 48.22MB 73.7s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 74.8s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 3.15MB / 42.62MB 78.3s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 16.78MB / 48.22MB 78.8s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 79.9s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 16.78MB / 48.22MB 83.8s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 1.05MB / 3.64MB 85.0s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 87.0s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 19.92MB / 48.22MB 87.9s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 3.15MB / 42.62MB 88.6s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 23.07MB / 48.22MB 91.8s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 92.0s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 26.21MB / 48.22MB 95.7s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 97.2s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 3.15MB / 42.62MB 98.7s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 26.21MB / 48.22MB 100.8s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 102.4s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 26.21MB / 48.22MB 105.8s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 107.4s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 3.15MB / 42.62MB 108.8s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 28.31MB / 48.22MB 110.9s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 112.5s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 31.46MB / 48.22MB 114.1s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 34.60MB / 48.22MB 116.8s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 117.6s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 5.24MB / 42.62MB 118.9s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 37.75MB / 48.22MB 121.1s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 122.7s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 40.89MB / 48.22MB 123.6s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 44.04MB / 48.22MB 127.2s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 127.8s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 6.29MB / 42.62MB 129.0s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 46.14MB / 48.22MB 132.3s
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 133.0s
#9 sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 48.22MB / 48.22MB 134.0s done
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 11.53MB / 42.62MB 137.4s
#7 sha256:2a055f0c83be4329e887452a8868e5e83bde34eda9f7e582de5833dc9dc53446 0B / 1.26MB 137.4s
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 137.9s
#7 sha256:2a055f0c83be4329e887452a8868e5e83bde34eda9f7e582de5833dc9dc53446 1.05MB / 1.26MB 138.5s
#7 sha256:2a055f0c83be4329e887452a8868e5e83bde34eda9f7e582de5833dc9dc53446 1.26MB / 1.26MB 138.6s done
#7 sha256:0416551166ae31475d009b5a4100c21041df7fb1720d2361d5138bc9144acbc9 446B / 446B 138.8s done
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 14.68MB / 42.62MB 141.2s
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 142.9s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 15.73MB / 42.62MB 146.3s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 148.1s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 18.87MB / 42.62MB 148.9s
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 153.2s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 19.92MB / 42.62MB 154.0s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 158.3s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 23.07MB / 42.62MB 159.1s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 26.21MB / 42.62MB 161.7s
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 163.4s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 29.36MB / 42.62MB 163.9s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 32.51MB / 42.62MB 166.4s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 35.65MB / 42.62MB 168.0s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 168.4s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 37.75MB / 42.62MB 173.1s
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 173.6s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 40.89MB / 42.62MB 176.6s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 178.6s
#7 sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 42.62MB / 42.62MB 179.9s done
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 183.6s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 188.8s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 193.7s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 198.9s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 203.9s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 209.1s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 214.0s
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 2.10MB / 3.64MB 219.3s
#9 ...

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 3.15MB / 3.64MB 224.0s
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 3.64MB / 3.64MB 224.1s
#7 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 3.64MB / 3.64MB 224.1s done
#7 extracting sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 0.1s
#7 extracting sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 0.2s done
#7 extracting sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc
#7 extracting sha256:905fb610ce71a10484abc2df972ec07b30088dabb8eedeb665f1ea50ff47b3cc 2.2s done
#7 extracting sha256:2a055f0c83be4329e887452a8868e5e83bde34eda9f7e582de5833dc9dc53446
#7 ...

#9 [traefik 1/4] FROM docker.io/library/traefik:v3.3.3@sha256:19884a9d0b922b321c9cff54cbfe43f3169893041b8dd4ea6100677afaddce46
#9 sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 3.64MB / 3.64MB 224.3s done
#9 extracting sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870 0.2s done
#9 extracting sha256:660f734330e488ab9aaa6fadf5f53a683376b1746ed6e941829076f5db4e7c0b 0.2s done
#9 extracting sha256:0af947afec58590551b9495ecb0d7658503cd62efcd73c7220ad566f650a7bf2 1.7s done
#9 extracting sha256:b6438ad7918fa97f72c113419bad1eba7588624de0c03eb4fed58cd65a20f73b done
#9 DONE 227.5s

#7 [fastify 1/6] FROM docker.io/library/node:20-alpine@sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea
#7 extracting sha256:2a055f0c83be4329e887452a8868e5e83bde34eda9f7e582de5833dc9dc53446 0.2s done
#7 extracting sha256:0416551166ae31475d009b5a4100c21041df7fb1720d2361d5138bc9144acbc9 done
#7 DONE 227.9s

#10 [traefik 2/4] RUN apk add --no-cache curl ca-certificates openssl && 	mkdir -p /etc/traefik
#10 0.962 fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/main/x86_64/APKINDEX.tar.gz
#10 1.804 fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/community/x86_64/APKINDEX.tar.gz
#10 ...

#11 [fastify 2/6] RUN apk update && apk add --no-cache curl ca-certificates openssl sqlite python3 make g++
#11 0.543 fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/main/x86_64/APKINDEX.tar.gz
#11 ...

#10 [traefik 2/4] RUN apk add --no-cache curl ca-certificates openssl && 	mkdir -p /etc/traefik
#10 11.45 (1/10) Installing brotli-libs (1.1.0-r2)
#10 12.04 (2/10) Installing c-ares (1.34.3-r0)
#10 12.09 (3/10) Installing libunistring (1.2-r0)
#10 12.30 (4/10) Installing libidn2 (2.3.7-r0)
#10 12.34 (5/10) Installing nghttp2-libs (1.64.0-r0)
#10 12.38 (6/10) Installing libpsl (0.21.5-r3)
#10 12.40 (7/10) Installing zstd-libs (1.5.6-r2)
#10 12.86 (8/10) Installing libcurl (8.12.1-r0)
#10 12.98 (9/10) Installing curl (8.12.1-r0)
#10 13.06 (10/10) Installing openssl (3.3.3-r0)
#10 13.15 Executing busybox-1.37.0-r12.trigger
#10 13.16 OK: 13 MiB in 27 packages
#10 DONE 15.2s

#12 [traefik 3/4] RUN touch /etc/traefik/acme.json && chmod 600 /etc/traefik/acme.json
#12 DONE 0.6s

#11 [fastify 2/6] RUN apk update && apk add --no-cache curl ca-certificates openssl sqlite python3 make g++
#11 13.18 fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/community/x86_64/APKINDEX.tar.gz
#11 14.68 v3.21.3-95-g22c7b41f717 [https://dl-cdn.alpinelinux.org/alpine/v3.21/main]
#11 14.68 v3.21.3-123-g99f723e4785 [https://dl-cdn.alpinelinux.org/alpine/v3.21/community]
#11 14.68 OK: 25395 distinct packages available
#11 14.75 fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/main/x86_64/APKINDEX.tar.gz
#11 15.08 fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/community/x86_64/APKINDEX.tar.gz
#11 ...

#13 [traefik 4/4] WORKDIR /etc/traefik/
#13 DONE 0.1s

#14 [traefik] exporting to image
#14 exporting layers
#14 exporting layers 0.2s done
#14 writing image sha256:c2f5ca31ee815244b6126d23f230b1c77194e97913e09386467377dd361a47f6 done
#14 naming to docker.io/library/ft_transcendence-traefik 0.0s done
#14 DONE 0.3s

#11 [fastify 2/6] RUN apk update && apk add --no-cache curl ca-certificates openssl sqlite python3 make g++
#11 15.94 (1/40) Installing ca-certificates (20241121-r1)
#11 ...

#15 [traefik] resolving provenance for metadata file
#15 DONE 0.0s

#11 [fastify 2/6] RUN apk update && apk add --no-cache curl ca-certificates openssl sqlite python3 make g++
#11 16.48 (2/40) Installing brotli-libs (1.1.0-r2)
#11 16.61 (3/40) Installing c-ares (1.34.3-r0)
#11 16.66 (4/40) Installing libunistring (1.2-r0)
#11 16.86 (5/40) Installing libidn2 (2.3.7-r0)
#11 16.91 (6/40) Installing nghttp2-libs (1.64.0-r0)
#11 16.94 (7/40) Installing libpsl (0.21.5-r3)
#11 16.97 (8/40) Installing zstd-libs (1.5.6-r2)
#11 17.07 (9/40) Installing libcurl (8.12.1-r0)
#11 17.90 (10/40) Installing curl (8.12.1-r0)
#11 17.96 (11/40) Installing libstdc++-dev (14.2.0-r4)
#11 21.55 (12/40) Installing jansson (2.14-r4)
#11 21.57 (13/40) Installing binutils (2.43.1-r1)
#11 23.36 (14/40) Installing libgomp (14.2.0-r4)
#11 23.41 (15/40) Installing libatomic (14.2.0-r4)
#11 23.42 (16/40) Installing gmp (6.3.0-r2)
#11 25.10 (17/40) Installing isl26 (0.26-r1)
#11 25.92 (18/40) Installing mpfr4 (4.2.1-r0)
#11 26.02 (19/40) Installing mpc1 (1.3.1-r1)
#11 26.04 (20/40) Installing gcc (14.2.0-r4)
#11 73.54 (21/40) Installing musl-dev (1.2.5-r9)
#11 74.68 (22/40) Installing g++ (14.2.0-r4)
#11 80.28 (23/40) Installing make (4.4.1-r2)
#11 80.32 (24/40) Installing openssl (3.3.3-r0)
#11 80.43 (25/40) Installing libbz2 (1.0.8-r6)
#11 80.45 (26/40) Installing libexpat (2.6.4-r0)
#11 80.48 (27/40) Installing libffi (3.4.7-r0)
#11 80.49 (28/40) Installing gdbm (1.24-r0)
#11 80.51 (29/40) Installing xz-libs (5.6.3-r0)
#11 80.54 (30/40) Installing mpdecimal (4.0.0-r0)
#11 80.58 (31/40) Installing ncurses-terminfo-base (6.5_p20241006-r3)
#11 80.59 (32/40) Installing libncursesw (6.5_p20241006-r3)
#11 80.63 (33/40) Installing libpanelw (6.5_p20241006-r3)
#11 80.64 (34/40) Installing readline (8.2.13-r0)
#11 80.67 (35/40) Installing sqlite-libs (3.48.0-r0)
#11 80.95 (36/40) Installing python3 (3.12.9-r0)
#11 83.69 (37/40) Installing python3-pycache-pyc0 (3.12.9-r0)
#11 85.09 (38/40) Installing pyc (3.12.9-r0)
#11 85.09 (39/40) Installing python3-pyc (3.12.9-r0)
#11 85.09 (40/40) Installing sqlite (3.48.0-r0)
#11 85.42 Executing busybox-1.37.0-r12.trigger
#11 85.42 Executing ca-certificates-20241121-r1.trigger
#11 85.47 OK: 276 MiB in 57 packages
#11 DONE 86.2s

#16 [fastify 3/6] WORKDIR /usr/src/app
#16 DONE 0.2s

#17 [fastify 4/6] COPY package*.json ./
#17 DONE 0.1s

#18 [fastify 5/6] RUN npm install --include=dev
#18 30.43 npm warn deprecated are-we-there-yet@3.0.1: This package is no longer supported.
#18 30.60 npm warn deprecated @npmcli/move-file@1.1.2: This functionality has been moved to @npmcli/fs
#18 30.74 npm warn deprecated gauge@4.0.4: This package is no longer supported.
#18 30.79 npm warn deprecated inflight@1.0.6: This module is not supported, and leaks memory. Do not use it. Check out lru-cache if you want a good and tested way to coalesce async requests by a key value, which is much more comprehensive and powerful.
#18 30.79 npm warn deprecated npmlog@6.0.2: This package is no longer supported.
#18 30.81 npm warn deprecated rimraf@3.0.2: Rimraf versions prior to v4 are no longer supported
#18 30.85 npm warn deprecated glob@7.2.3: Glob versions prior to v9 are no longer supported
#18 39.52 npm error code 1
#18 39.52 npm error path /usr/src/app/node_modules/sqlite3
#18 39.52 npm error command failed
#18 39.52 npm error command sh -c prebuild-install -r napi || node-gyp rebuild
#18 39.52 npm error prebuild-install warn install getaddrinfo ENOTFOUND github.com
#18 39.52 npm error gyp info it worked if it ends with ok
#18 39.52 npm error gyp info using node-gyp@8.4.1
#18 39.52 npm error gyp info using node@20.18.3 | linux | x64
#18 39.52 npm error gyp info find Python using Python version 3.12.9 found at "/usr/bin/python3"
#18 39.52 npm error gyp http GET https://unofficial-builds.nodejs.org/download/release/v20.18.3/node-v20.18.3-headers.tar.gz
#18 39.52 npm error gyp WARN install got an error, rolling back install
#18 39.52 npm error gyp ERR! configure error 
#18 39.52 npm error gyp ERR! stack Error: This is most likely not a problem with node-gyp or the package itself and
#18 39.52 npm error gyp ERR! stack is related to network connectivity. In most cases you are behind a proxy or have bad 
#18 39.52 npm error gyp ERR! stack network settings.
#18 39.52 npm error gyp ERR! stack     at go (/usr/src/app/node_modules/node-gyp/lib/install.js:173:17)
#18 39.52 npm error gyp ERR! stack     at process.processTicksAndRejections (node:internal/process/task_queues:95:5)
#18 39.52 npm error gyp ERR! stack     at async install (/usr/src/app/node_modules/node-gyp/lib/install.js:62:18)
#18 39.52 npm error gyp ERR! System Linux 5.15.167.4-microsoft-standard-WSL2
#18 39.52 npm error gyp ERR! command "/usr/local/bin/node" "/usr/src/app/node_modules/.bin/node-gyp" "rebuild"
#18 39.52 npm error gyp ERR! cwd /usr/src/app/node_modules/sqlite3
#18 39.52 npm error gyp ERR! node -v v20.18.3
#18 39.52 npm error gyp ERR! node-gyp -v v8.4.1
#18 39.52 npm error gyp ERR! not ok
#18 39.53 npm notice
#18 39.53 npm notice New major version of npm available! 10.8.2 -> 11.2.0
#18 39.53 npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.2.0
#18 39.53 npm notice To update run: npm install -g npm@11.2.0
#18 39.53 npm notice
#18 39.53 npm error A complete log of this run can be found in: /root/.npm/_logs/2025-03-06T22_15_01_373Z-debug-0.log
#18 ERROR: process "/bin/sh -c npm install --include=dev" did not complete successfully: exit code: 1
------
 > [fastify 5/6] RUN npm install --include=dev:
39.52 npm error gyp ERR! cwd /usr/src/app/node_modules/sqlite3
39.52 npm error gyp ERR! node -v v20.18.3
39.52 npm error gyp ERR! node-gyp -v v8.4.1
39.52 npm error gyp ERR! not ok
39.53 npm notice
39.53 npm notice New major version of npm available! 10.8.2 -> 11.2.0
39.53 npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.2.0
39.53 npm notice To update run: npm install -g npm@11.2.0
39.53 npm notice
39.53 npm error A complete log of this run can be found in: /root/.npm/_logs/2025-03-06T22_15_01_373Z-debug-0.log
------
failed to solve: process "/bin/sh -c npm install --include=dev" did not complete successfully: exit code: 1
