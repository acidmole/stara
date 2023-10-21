FROM ruby:3.1.2

EXPOSE 3000

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN gem install bundler

RUN bundle install

COPY . .

RUN rails db:migrate

CMD ["rails", "s", "-b", "127.0.0.1", "-e", "development"]


