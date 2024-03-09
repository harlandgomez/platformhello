var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", (HttpContext httpContext) =>
    $"Welcome To 2022! Your user agent is: {httpContext.Request.Headers["User-Agent"]}");


app.Run();
