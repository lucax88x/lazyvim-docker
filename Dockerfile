# Start with Alpine Edge
FROM alpine:edge

# Install required packages
RUN apk add git lazygit neovim ripgrep alpine-sdk --update

WORKDIR /root

# Clone LazyVim starter configuration
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim

# Set environment variables
ENV TERM=xterm-256color
ENV EDITOR=nvim

# Set the entrypoint
ENTRYPOINT ["nvim"]
