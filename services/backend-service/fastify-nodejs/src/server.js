// server.js
import Fastify from 'fastify';
import dotenv from 'dotenv';

dotenv.config();

const fastify = Fastify({ logger: true });

fastify.get('/', async (request, reply) => {
  return { hello: 'world' };
});

fastify.get('/health', async (request, reply) => {
  return { status: 'ok' };
});

const start = async () => {
	try {
	  await fastify.listen({ port: 3000, host: '0.0.0.0' });
	  fastify.log.info(`Server listening on ${fastify.server.address().port}`);
	} catch (err) {
	  fastify.log.error(err);
	  process.exit(1);
	}
  };
  
  start();