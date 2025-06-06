FROM ruby:3.2

WORKDIR /app
COPY . .
RUN gem install bundler && bundle install

ARG PORT=8000
ARG RACK_ENV=production

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
