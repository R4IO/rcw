#!/bin/bash

Rscript -e 'testthat::test_file("./tests/testthat/test-create_config.R")'
# Rscript -e 'testthat::test_file("./tests/testthat/test-post_config.R")'
