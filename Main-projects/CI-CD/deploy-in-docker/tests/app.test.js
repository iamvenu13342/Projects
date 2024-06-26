const request = require('supertest');
const express = require('express');

const app = express();
app.get('/', (req, res) => {
  res.status(200).send('Hello World!');
});

describe('GET /', function() {
  it('respond with Hello World!', function(done) {
    request(app)
      .get('/')
      .expect('Hello World!', done);
  });
});
