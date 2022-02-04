# Single Docker image for Nginx & Streamlit
Microservice helps to operate each service independently that is why we use separate docker images within docker compose. [Nginx](https://www.nginx.com/) is the most popular microservice in the industry. unfortunately, sometimes we ought to combine plural services in the single docker image.

[Streamlit](https://streamlit.io/) is an awesome library to deploy easily without expertise in frontend skills. It can plot beautiful graphs, or predict a result based on the machine learning models.

In this repository, I will make a demo for proxy server with streamlit application. The application exposes their service through port number `2022`, and Nginx server exposes to the port number `8888` in the demo. Then, you can see Streamlit application with `localhost:8888` in your webbrowser. Of course, it is possible to run the application with `localhost:2022` due to the fact that I did not set any blocking other port numbers in Nginx configuration.

## Demo
- Create the docker image using by `app_build.sh` script.
- Run the docker container using by `app_run.sh` script.
- Check the logs which are running at Streamlit application. It runs `http://0.0.0.0:2022`
- Open your webbrowser and hit `localhost:8888`. Also, you can check to hit `localhost:2022`

## Source
- The original code for Streamlit application is from this [repository](https://github.com/streamlit/release-demos), and its [License](https://github.com/streamlit/release-demos/blob/master/LICENSE).
