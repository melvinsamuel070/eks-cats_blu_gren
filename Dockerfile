# FROM ruby:3.2

# WORKDIR /app
# COPY . .
# RUN gem install bundler && bundle install

# ARG PORT=8000
# ARG RACK_ENV=production

# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]



FROM ruby:3.2

WORKDIR /app
COPY . .

# Set version from build argument with default
ARG APP_VERSION=1.0.0
ENV APP_VERSION=${APP_VERSION}

# Install dependencies
RUN gem install bundler && bundle install

# Application configuration
ARG PORT=8000
ARG RACK_ENV=production
ENV RACK_ENV=${RACK_ENV}

EXPOSE ${PORT}
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]