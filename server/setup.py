from setuptools import find_packages, setup

setup(
    name="sana",
    version="1.0.0",
    author="Md. Faisal Ahammad",
    author_email="ahammad.labs@gmail.com",
    description="Sana - an AI-enabled medical assistant (RAG over medical literature).",
    packages=find_packages(include=["sana", "sana.*"]),
    python_requires=">=3.10",
    install_requires=[]
)
