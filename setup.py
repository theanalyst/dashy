from setuptools import setup

PKG = "dashy"

long_description = """Macros and Utilities for hy which are highly
inspired from dash.el of Emacs"""

install_requires = ['hy >=0.9.10']
__version__ = "0.1"

setup (
    name=PKG,
    version=__version__,
    install_requires=install_requires,
    packages=['dash'],
    package_data={'dash': ['*.hy']},
    author="Abhishek L",
    author_email="xxx@gmail.com",
    long_description=long_description,
    description="dash.el like utilities for hy",
    license="Expat",
    platforms=['any'],
    classifiers=[
        "Development Status :: 1 - alpha",
        "Intended Audience :: Developers",
        "License :: DFSG approved",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Lisp",
        "Programming Language :: Python",
        "Programming Language :: Python :: 2",
        "Programming Language :: Python :: 2.6",
        "Programming Language :: Python :: 2.7",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.2",
        "Programming Language :: Python :: 3.3",
        "Topic :: Software Development :: Libraries",
    ]
)










