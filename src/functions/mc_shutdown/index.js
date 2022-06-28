const AWS = require("aws-sdk");
var ec2 = new AWS.EC2();

exports.handler = async (event) => {
  try {
    var result;
    var params = {
      InstanceIds: [process.env.INSTANCE_ID],
    };
    var data = await ec2.describeInstances(params).promise();
    var instance = data.Reservations[0].Instances[0];

    if (instance.State.Name !== "stopped") {
      var launch_time = new Date(instance.LaunchTime);
      var today = new Date();
      result = "instance running";
      if ((today - launch_time) / 3600000 > process.env.MAX_HOURS) {
        console.log("stopping the instance...");
        var stop_data = await ec2.stopInstances(params).promise();
        result = "instance stopped";
      }
    } else {
      result = "instance not running";
    }
    const response = {
      statusCode: 200,
      body: result,
    };
    return response;
  } catch (error) {
    console.error(error);
    const response = {
      statusCode: 500,
      body: "error during script",
    };
    return response;
  }
};