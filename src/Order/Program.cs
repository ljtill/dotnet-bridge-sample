var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

var items = new[]
{
    "1", "2", "3", "4", "5"
};

app.MapGet("/order", () =>
{
    app.Logger.LogInformation("GetOrder called");
    return items;
})
.WithName("GetOrder")
.WithOpenApi();

app.Run();
