#!/usr/bin/env bash
mkdir /external_includes
cd /external_includes
printf "<?php
  $wgDBserver = $DBserver;
  $wgDBname = $DBname;
  $wgDBuser = $DBuser;
  $wgDBpassword = $DBpassword;
?>" | sudo tee LocalSettings.php
