@echo off
title FIFA BD Countdown Local Server
echo Starting local server at http://localhost:5500
echo Keep this window open while testing.
start "" http://localhost:5500
python -m http.server 5500
pause
