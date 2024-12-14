#!/bin/bash
mongosh mongodb://localhost:27017/lichess < /docker-entrypoint-initdb.d/indexes.js