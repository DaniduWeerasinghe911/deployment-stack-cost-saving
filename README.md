# Save Cost with Azure Bicep Deployment Stacks ?

This time I’m here to talk about how to save cost using Azure Deployment Stacks. Assume everyone has a pretty good understanding about deployment stacks, let’s see how we can use if for our advantage. To talk about it, I’m going to use a scenario. I believe it’s the best way to explain and simulate the situation

Scenario

In our azure environment we have few virtual machines, and we use azure bastion to access the VMs, but our work only between 8am to 5pm. So, there is no point running Azure bastion 24/7 rather we save some money.

Here is the plan of attack

- Bicep template to deploy Azure bastion
- Have a variable to deploy bastion or not in the template
- Create a scheduled devops pipeline and change the variable accordingly

Following is my bicep template, its a simple file just to show the process. there may be lot of hard coded values.

![image](https://github.com/user-attachments/assets/0eccd10b-2e7c-4d9f-b7e7-f06b1c6ca541)


important variable here is deployResource Bool value

Here is my pipeline files

I create 2 files to run on 2 schedules. one at morning 6am

<note: in this pipeline my deploy resources parameter is set to true, as i wanted to get bastion deployed in the morning>
![image](https://github.com/user-attachments/assets/db7a7285-6689-409e-83c9-a220d2dd43b7)

and second one at 6pm

<note: in this pipeline my deploy resources parameter is set to false, as i wanted to delete bastion in the afternoon>

Based on how deployment stack works following is the output at

6am everyday
![image](https://github.com/user-attachments/assets/96c45206-5022-4438-9a05-df5af96ec748)


6pm everyday
![image](https://github.com/user-attachments/assets/a42d1320-344e-46e0-83e3-be0366b18550)


You can use this methodology to many scenarios

If you have dev environments and if wanna save more cost
Unwanted resources during office hours like Azure bastions etc. ( Which gonna get charged once get provisioned)
And you might think why not use the same pipeline, I have few reasons behind it

Wanted differentiate runs easily
We have more flexibility when running things or scheuduling things
Keep things simple
And definitely there is no problem using the same pipeline and achieve the same thing.

Also in the pipeline you can improve it by using pipeline templates and use variables intead of parameters etc.

## Conclusion
I wanted to show the power behind using Azure IAC, Deployment stacks and Pipelines, anyone who is leveraging these practices can manage you Azure cloud environment effectively and cost efficiently. Above example shows saving azure bastion cost by a half. So depending on your scenario and use case you can save more money without need to thing about reservations etc.
