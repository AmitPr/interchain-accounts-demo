#!/bin/bash

BINARY=icad
BINARY2=kujirad
CHAIN_DIR=./data
CHAINID_1=test-1
CHAINID_2=test-2
CHAINID_3=localkujira
GRPCPORT_1=8090
GRPCPORT_2=9090
GRPCPORT_3=10090
GRPCWEB_1=8091
GRPCWEB_2=9091
GRPCWEB_3=10091


echo "Starting $CHAINID_1 in $CHAIN_DIR..."
echo "Creating log file at $CHAIN_DIR/$CHAINID_1.log"
$BINARY start --log_level info --log_format json --home $CHAIN_DIR/$CHAINID_1 --pruning=nothing --grpc.address="0.0.0.0:$GRPCPORT_1" --grpc-web.address="0.0.0.0:$GRPCWEB_1" > $CHAIN_DIR/$CHAINID_1.log 2>&1 &

echo "Starting $CHAINID_2 in $CHAIN_DIR..."
echo "Creating log file at $CHAIN_DIR/$CHAINID_2.log"
$BINARY start --log_level info --log_format json --home $CHAIN_DIR/$CHAINID_2 --pruning=nothing --grpc.address="0.0.0.0:$GRPCPORT_2" --grpc-web.address="0.0.0.0:$GRPCWEB_2" --api.address "tcp://localhost:1318" > $CHAIN_DIR/$CHAINID_2.log 2>&1 &

echo "Starting $CHAINID_3 in $CHAIN_DIR..."
echo "Creating log file at $CHAIN_DIR/$CHAINID_3.log"
$BINARY2 start --log_level info --log_format json --home $CHAIN_DIR/$CHAINID_3 --pruning=nothing --grpc.address="0.0.0.0:$GRPCPORT_3" --grpc-web.address="0.0.0.0:$GRPCWEB_3" --api.address "tcp://localhost:1319" > $CHAIN_DIR/$CHAINID_3.log 2>&1 &