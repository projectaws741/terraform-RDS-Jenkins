To destroy add the destroy command in Jenkins pipeline as below.

sh """
                            terraform destroy -auto-approve \
                            -var AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} \
                            -var AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY} \
                            -var AWS_REGION=${env.TF_BACKEND_REGION}
                        """

Here we have another jenkins file JenkinsAWS Creds. In that file aws acesskey and secret acesskey is fetched from aws parameter store. So please create aceeskey and secret acess key in aws parameter strore using secure string. Jenkins server must have role in order to fetch the parameters from systems manager.
