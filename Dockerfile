FROM ruby:3.2.1
ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apt-get update -qq
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs mariadb-client
RUN npm install --global yarn

WORKDIR ${ROOT}

COPY Gemfile Gemfile.lock ${ROOT}
RUN gem install bundler
RUN bundle install --jobs 4

EXPOSE 3000 3306
