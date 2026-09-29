# Use a stable Python base image
FROM python:3.11-slim

# Hugging Face requires a user with UID 1000
RUN useradd -m -u 1000 user
USER user

# Set environment variables for the user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH \
    PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR $HOME/app

# Copy only the backend (app.py, sana/, setup.py, requirements.txt)
COPY --chown=user server/ .

# Install runtime dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Expose the required port
EXPOSE 7860

# Command to run the application
CMD ["python", "app.py"]