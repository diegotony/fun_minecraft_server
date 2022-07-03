# -*- coding: utf-8 -*-
# diagram.py
from diagram import Diagram
from diagrams.aws.compute import EC2,EC2Instance, Lambda
from diagrams.aws.management import CloudwatchRule

with Diagram("fun_minecraft_server",filename="diagram", show=False, direction="TB"):
    shutdown = Lambda("lambda_mc_shutdown")
    start = Lambda("lambda_mc_start")
    server = EC2("minecraft_server")

    server - [shutdown,start]

    shutdown << CloudwatchRule("alive_minecraft_rule")
