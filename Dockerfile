# Create ruby environment and dependencies. NodeJS, Postgres, Nokogiri, Yarnw
FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential apt-utils 
RUN apt-get install -y nodejs postgresql-client
RUN apt-get install -y libxml2-dev libxslt1-dev
RUN apt-get install -y yarn
RUN gem install bundler


# Create the working directory
RUN mkdir /jobio
WORKDIR /jobio
COPY Gemfile /jobio/Gemfile
COPY Gemfile.lock /jobio/Gemfile.lock
RUN bundle install
COPY . /jobio

# Create an entrypoint to be started everytime. Needed because of a rails issue according to Docker
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

