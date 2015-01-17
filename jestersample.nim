import jester, asyncdispatch, asyncnet

routes:
    get "/":
        await resp "Hello World"

runForever()
