#!/bin/bash

BINARY=icad
BINARY2=kujirad
CHAIN_DIR=./data
CHAINID_1=test-1
CHAINID_2=test-2
CHAINID_3=localkujira

VAL_MNEMONIC_1="clock post desk civil pottery foster expand merit dash seminar song memory figure uniform spice circle try happy obvious trash crime hybrid hood cushion"
VAL_MNEMONIC_2="angry twist harsh drastic left brass behave host shove marriage fall update business leg direct reward object ugly security warm tuna model broccoli choice"
WALLET_MNEMONIC_1="banner spread envelope side kite person disagree path silver will brother under couch edit food venture squirrel civil budget number acquire point work mass"
WALLET_MNEMONIC_2="veteran try aware erosion drink dance decade comic dawn museum release episode original list ability owner size tuition surface ceiling depth seminar capable only"
WALLET_MNEMONIC_3="vacuum burst ordinary enact leaf rabbit gather lend left chase park action dish danger green jeans lucky dish mesh language collect acquire waste load"
WALLET_MNEMONIC_4="open attitude harsh casino rent attitude midnight debris describe spare cancel crisp olive ride elite gallery leaf buffalo sheriff filter rotate path begin soldier"
RLY_MNEMONIC_1="alley afraid soup fall idea toss can goose become valve initial strong forward bright dish figure check leopard decide warfare hub unusual join cart"
RLY_MNEMONIC_2="record gift you once hip style during joke field prize dust unique length more pencil transfer quit train device arrive energy sort steak upset"

P2PPORT_1=16656
P2PPORT_2=26656
P2PPORT_3=36656
RPCPORT_1=16657
RPCPORT_2=26657
RPCPORT_3=36657
RESTPORT_1=1317
RESTPORT_2=1318
RESTPORT_3=1319
ROSETTA_1=8080
ROSETTA_2=8081
ROSETTA_3=8082

# Stop if it is already running 
if pgrep -x "$BINARY" >/dev/null; then
    echo "Terminating $BINARY..."
    killall $BINARY
fi

if pgrep -x "$BINARY2" >/dev/null; then
    echo "Terminating $BINARY2..."
    killall $BINARY2
fi

echo "Removing previous data..."
rm -rf $CHAIN_DIR/$CHAINID_1 &> /dev/null
rm -rf $CHAIN_DIR/$CHAINID_2 &> /dev/null
rm -rf $CHAIN_DIR/$CHAINID_3 &> /dev/null

# Add directories for both chains, exit if an error occurs
if ! mkdir -p $CHAIN_DIR/$CHAINID_1 2>/dev/null; then
    echo "Failed to create chain folder. Aborting..."
    exit 1
fi

if ! mkdir -p $CHAIN_DIR/$CHAINID_2 2>/dev/null; then
    echo "Failed to create chain folder. Aborting..."
    exit 1
fi

if ! mkdir -p $CHAIN_DIR/$CHAINID_3 2>/dev/null; then
    echo "Failed to create chain folder. Aborting..."
    exit 1
fi

echo "Initializing $CHAINID_1..."
echo "Initializing $CHAINID_2..."
echo "Initializing $CHAINID_3..."
$BINARY init test --home $CHAIN_DIR/$CHAINID_1 --chain-id=$CHAINID_1
$BINARY init test --home $CHAIN_DIR/$CHAINID_2 --chain-id=$CHAINID_2
$BINARY2 init test --home $CHAIN_DIR/$CHAINID_3 --chain-id=$CHAINID_3

echo "Adding genesis accounts..."
echo $VAL_MNEMONIC_1 | $BINARY keys add val1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test
echo $VAL_MNEMONIC_1 | $BINARY2 keys add val1 --home $CHAIN_DIR/$CHAINID_3 --recover --keyring-backend=test
echo $VAL_MNEMONIC_2 | $BINARY keys add val2 --home $CHAIN_DIR/$CHAINID_2 --recover --keyring-backend=test
echo $WALLET_MNEMONIC_1 | $BINARY keys add wallet1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test
echo $WALLET_MNEMONIC_2 | $BINARY keys add wallet2 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test
echo $WALLET_MNEMONIC_1 | $BINARY2 keys add wallet1 --home $CHAIN_DIR/$CHAINID_3 --recover --keyring-backend=test
echo $WALLET_MNEMONIC_2 | $BINARY2 keys add wallet2 --home $CHAIN_DIR/$CHAINID_3 --recover --keyring-backend=test
echo $WALLET_MNEMONIC_3 | $BINARY keys add wallet3 --home $CHAIN_DIR/$CHAINID_2 --recover --keyring-backend=test
echo $WALLET_MNEMONIC_4 | $BINARY keys add wallet4 --home $CHAIN_DIR/$CHAINID_2 --recover --keyring-backend=test
echo $RLY_MNEMONIC_1 | $BINARY keys add rly1 --home $CHAIN_DIR/$CHAINID_1 --recover --keyring-backend=test 
echo $RLY_MNEMONIC_1 | $BINARY2 keys add rly1 --home $CHAIN_DIR/$CHAINID_3 --recover --keyring-backend=test
echo $RLY_MNEMONIC_2 | $BINARY keys add rly2 --home $CHAIN_DIR/$CHAINID_2 --recover --keyring-backend=test 

$BINARY genesis add-genesis-account $($BINARY --home $CHAIN_DIR/$CHAINID_1 keys show val1 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_1
$BINARY2 genesis add-genesis-account $($BINARY2 --home $CHAIN_DIR/$CHAINID_3 keys show val1 --keyring-backend test -a) 100000000000ukuji  --home $CHAIN_DIR/$CHAINID_3
$BINARY genesis add-genesis-account $($BINARY --home $CHAIN_DIR/$CHAINID_2 keys show val2 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_2
$BINARY genesis add-genesis-account $($BINARY --home $CHAIN_DIR/$CHAINID_1 keys show wallet1 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_1
$BINARY2 genesis add-genesis-account $($BINARY2 --home $CHAIN_DIR/$CHAINID_3 keys show wallet1 --keyring-backend test -a) 100000000000ukuji  --home $CHAIN_DIR/$CHAINID_3
$BINARY genesis add-genesis-account $($BINARY --home $CHAIN_DIR/$CHAINID_1 keys show wallet2 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_1
$BINARY2 genesis add-genesis-account $($BINARY2 --home $CHAIN_DIR/$CHAINID_3 keys show wallet2 --keyring-backend test -a) 100000000000ukuji  --home $CHAIN_DIR/$CHAINID_3
$BINARY genesis add-genesis-account $($BINARY --home $CHAIN_DIR/$CHAINID_2 keys show wallet3 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_2
$BINARY genesis add-genesis-account $($BINARY --home $CHAIN_DIR/$CHAINID_2 keys show wallet4 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_2
$BINARY genesis add-genesis-account $($BINARY --home $CHAIN_DIR/$CHAINID_1 keys show rly1 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_1
$BINARY2 genesis add-genesis-account $($BINARY2 --home $CHAIN_DIR/$CHAINID_3 keys show rly1 --keyring-backend test -a) 100000000000ukuji  --home $CHAIN_DIR/$CHAINID_3
$BINARY genesis add-genesis-account $($BINARY --home $CHAIN_DIR/$CHAINID_2 keys show rly2 --keyring-backend test -a) 100000000000stake  --home $CHAIN_DIR/$CHAINID_2

echo "Creating and collecting gentx..."
$BINARY genesis gentx val1 7000000000stake --home $CHAIN_DIR/$CHAINID_1 --chain-id $CHAINID_1 --keyring-backend test
$BINARY2 genesis gentx val1 7000000000ukuji --home $CHAIN_DIR/$CHAINID_3 --chain-id $CHAINID_3 --keyring-backend test
$BINARY genesis gentx val2 7000000000stake --home $CHAIN_DIR/$CHAINID_2 --chain-id $CHAINID_2 --keyring-backend test
$BINARY genesis collect-gentxs --home $CHAIN_DIR/$CHAINID_1
$BINARY2 genesis collect-gentxs --home $CHAIN_DIR/$CHAINID_3
$BINARY genesis collect-gentxs --home $CHAIN_DIR/$CHAINID_2

echo "Changing defaults and ports in app.toml and config.toml files..."
sed -i -e 's#"tcp://0.0.0.0:26656"#"tcp://0.0.0.0:'"$P2PPORT_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's#"tcp://127.0.0.1:26657"#"tcp://0.0.0.0:'"$RPCPORT_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/timeout_commit = "5s"/timeout_commit = "1s"/g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/timeout_propose = "3s"/timeout_propose = "1s"/g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/index_all_keys = false/index_all_keys = true/g' $CHAIN_DIR/$CHAINID_1/config/config.toml
sed -i -e 's/enable = false/enable = true/g' $CHAIN_DIR/$CHAINID_1/config/app.toml
sed -i -e 's/swagger = false/swagger = true/g' $CHAIN_DIR/$CHAINID_1/config/app.toml
sed -i -e 's#"tcp://0.0.0.0:1317"#"tcp://0.0.0.0:'"$RESTPORT_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/app.toml
sed -i -e 's#":8080"#":'"$ROSETTA_1"'"#g' $CHAIN_DIR/$CHAINID_1/config/app.toml

sed -i -e 's#"tcp://0.0.0.0:26656"#"tcp://0.0.0.0:'"$P2PPORT_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's#"tcp://127.0.0.1:26657"#"tcp://0.0.0.0:'"$RPCPORT_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/timeout_commit = "5s"/timeout_commit = "1s"/g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/timeout_propose = "3s"/timeout_propose = "1s"/g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/index_all_keys = false/index_all_keys = true/g' $CHAIN_DIR/$CHAINID_2/config/config.toml
sed -i -e 's/enable = false/enable = true/g' $CHAIN_DIR/$CHAINID_2/config/app.toml
sed -i -e 's/swagger = false/swagger = true/g' $CHAIN_DIR/$CHAINID_2/config/app.toml
sed -i -e 's#"tcp://0.0.0.0:1317"#"tcp://0.0.0.0:'"$RESTPORT_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/app.toml
sed -i -e 's#":8080"#":'"$ROSETTA_2"'"#g' $CHAIN_DIR/$CHAINID_2/config/app.toml

sed -i -e 's#"tcp://0.0.0.0:26656"#"tcp://0.0.0.0:'"$P2PPORT_3"'"#g' $CHAIN_DIR/$CHAINID_3/config/config.toml
sed -i -e 's#"tcp://127.0.0.1:26657"#"tcp://0.0.0.0:'"$RPCPORT_3"'"#g' $CHAIN_DIR/$CHAINID_3/config/config.toml
sed -i -e 's/timeout_commit = "5s"/timeout_commit = "1s"/g' $CHAIN_DIR/$CHAINID_3/config/config.toml
sed -i -e 's/timeout_propose = "3s"/timeout_propose = "1s"/g' $CHAIN_DIR/$CHAINID_3/config/config.toml
sed -i -e 's/index_all_keys = false/index_all_keys = true/g' $CHAIN_DIR/$CHAINID_3/config/config.toml
sed -i -e 's/enable = false/enable = true/g' $CHAIN_DIR/$CHAINID_3/config/app.toml
sed -i -e 's/swagger = false/swagger = true/g' $CHAIN_DIR/$CHAINID_3/config/app.toml
sed -i -e 's#"tcp://0.0.0.0:1317"#"tcp://0.0.0.0:'"$RESTPORT_3"'"#g' $CHAIN_DIR/$CHAINID_3/config/app.toml
sed -i -e 's#":8080"#":'"$ROSETTA_3"'"#g' $CHAIN_DIR/$CHAINID_3/config/app.toml
sed -i -e 's#"tcp://localhost:26657"#"tcp://0.0.0.0:'"$RPCPORT_3"'"#g' $CHAIN_DIR/$CHAINID_3/config/client.toml

# Update host chain genesis to allow x/bank/MsgSend ICA tx execution
# sed -i -e 's/\"allow_messages\":.*/\"allow_messages\": [\"\/cosmos.bank.v1beta1.MsgSend\", \"\/cosmos.staking.v1beta1.MsgDelegate\"]/g' $CHAIN_DIR/$CHAINID_2/config/genesis.json
perl -i -pe 'BEGIN{undef $/;} s/"allow_messages":\s*\[\s*"\*"\s*\]/"allow_messages": ["\/cosmos.bank.v1beta1.MsgSend", "\/cosmos.staking.v1beta1.MsgDelegate"]/smg' $CHAIN_DIR/$CHAINID_2/config/genesis.json

# Kujira genesis change "stake" to "ukuji" when denom": "stake", is found
sed -i -e 's/denom": "stake"/denom": "ukuji"/g' $CHAIN_DIR/$CHAINID_3/config/genesis.json