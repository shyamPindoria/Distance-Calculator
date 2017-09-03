<h1>INFT 3033 - Mobile Application Enterprise Development</h1>
</span><h2>Assignment 1</h2><div class="box generalbox center clearfix"><div class="no-overflow"><h2>Distance Calculator</h2>
<p><strong>Value</strong>: 30%<br /><strong>Due Date</strong>: 1 October 2017 at 11:55 pm.</p>
<h3>Overview</h3>
<p>When developing auto navigation for devices, one common requirement is to have the vehicle travel a set distance and stop. There are a number of methods we can use to calculate when the vehicle has completed the distance sensors can measure the distance to a fixed object, GPS can give a general idea, accelerometers can determine the velocity it was moving at, and so on.</p>
<p>However, two common methods are:</p>
<ol>
<li>Determine how many times the wheels will need to rotate in order to travel the distance, and to use an encoder to count the rotations as the occur.</li>
<li>Determine how long it will take the vehicle to drive that distance at a set speed, and stop once the time is complete.</li>
</ol>
<p>The second option is ugly, but provides a quick-and-dirty solution. The first option is more reliable.</p>
<h3>Task</h3>
<p>You will need to develop an app into which the user can add three pieces of data:</p>
<ul>
<li>Wheel diameter</li>
<li>Revolutions Per Minute (RPM)</li>
<li>Target distance</li>
</ul>
<p>The app will then provide the time (in milliseconds) that it will take for the vehicle to travel the required distance, and the number of rotations that the wheel will need to make in order to travel that far. The basic formula you will need calculates the time it will take based on wheel diameter, a number of revolutions per minute (RPM), and distance. The formula is:</p>
<pre>Distance / (((pi * Diameter) / 60) * RPM) = Time</pre>
<p>If the diameter is provided in metres, the result will be the time in seconds to travel the distance.</p>
<h3>Requirements</h3>
<p>The minimum requirements to pass are:</p>
<ul>
<li>Must run in on an iPhone 7+ in portrait mode</li>
<li>Stable, so that it can not crash irrespective of what the user enters into the fields</li>
<li>Calculates time based on three parameters: RP/M, wheel diameter and distance</li>
<li>Requires no explanation beyond what is in the app to use</li>
<li>Clearly coded using best practise with clear comments</li>
<li>Use a design that is professional and suits the target audience</li>
</ul>
<p>To get a higher grade you will need to add additional features:</p>
<ul>
<li>Use auto layout tools to work well in landscape mode</li>
<li>Work on an iPad as well as different iPhone models</li>
<li>Provide the revolutions needed to travel the distance as well as the time</li>
<li>Allow the user to specify if the values are in millimetres or metres</li>
<li>Allow for wheel diameter in millimetres with distance in metres</li>
<li>Allow for imperial and metric measurements</li>
<li>Automatically convert imperial to metric and metric to imperial</li>
</ul>
<p>Other features will gain extra marks as appropriate. Creativity is always appreciated.</p>
<h3>Submission</h3>
<ul>
<li>You must bundle everything you use (including any additional libraries) into a zip file, together with the your own "TimeCalculator" folder (or whatever you called your app) containing all the files needed to build and run your app.</li>
<li>Rename your zip file using only your student ID.</li>
<li>Submit your zipped assignment using Learn Online.</li>
