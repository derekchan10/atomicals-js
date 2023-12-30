#!/bin/bash

source ./cli.sh

run () {
  ticket=$1
  gas_offset=${2:-0}
  gas_limit=${3:-0}
  gas_type=${4:-1}

  gas_fee=$(gas_fee)
  echo "gas_fee:$gas_fee"

  if [ $gas_limit -gt 0 ]; then
    if [ "$gas_type" == "2" ]; then
      if [ $gas_fee -ge $gas_limit ]; then
        gas_fee=$gas_limit
      fi
    else
      if [ $gas_fee -ge $gas_limit ]; then
        echo "gas too higher"
        sleep 3
        return 0
      fi

    fi

  fi

  gas_fee=$((gas_fee + gas_offset))

  # 调用命令,用$image传递文件名
  mint mint-dft $ticket --satsbyte="$gas_fee" --funding="funding" --disablechalk

  return 1
}

source ./start.sh

