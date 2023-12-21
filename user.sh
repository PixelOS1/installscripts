#!/bin/bash
useradd user
usermod -aG sudo user
ufw disable
