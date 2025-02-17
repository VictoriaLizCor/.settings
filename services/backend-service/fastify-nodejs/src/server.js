// server.js
const fastify = require('fastify')({ logger: true });

fastify.get('/', async (request, reply) => {
  return { hello: 'world' };
});
fastify.get('/health', async (request, reply) => {
	return { status: 'ok' };
});

const start = async () => {
  try {
    await fastify.listen(3000, '0.0.0.0');
    fastify.log.info(`Server listening on ${fastify.server.address().port}`);
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};
start();