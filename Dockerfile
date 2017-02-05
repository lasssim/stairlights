FROM hypriot/rpi-ruby

RUN apt-get update
RUN apt-get -y install build-essential 

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install --deployment --without development

COPY . /usr/src/app

CMD bundle exec ruby app.rb
