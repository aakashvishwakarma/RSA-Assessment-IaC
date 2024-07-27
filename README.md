# RSA-Assessment-IaC

This is the demo 3-tier web app and i have referneced and use this to create the network architecture.

![image](https://github.com/user-attachments/assets/073afc81-f6a2-4ba0-ac2d-b2fe3f4113df)


We have *tf-apply.yml* workflow-> It is use to deply the infr on the cloud , here we added terrascan for scanning of the terraform code and used the backed state management in S3. We have used the manaul approval step and need to change the credentials in secrets to make it work.

We have *tf-destory.yml* workflow-> It is going to destroy the created infrastructure using the statefile we created.

