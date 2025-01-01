To destroy add the destroy command in Jenkins pipeline as below.

sh """
                            terraform destroy -auto-approve \
                            -var AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} \
                            -var AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY} \
                            -var AWS_REGION=${env.TF_BACKEND_REGION}
                        """
