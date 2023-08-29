#!/bin/bash

processlist=$(ps -eo pid,rss --sort=-rss)
pid=$(echo $processlist | cut -d' ' -f3)
kill -9 $pid
