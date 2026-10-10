def calculate_average(numbers):
    total = sum(numbers)
    return total / len(numbers)


def main():
    temperatures = [21.5, 22.3, 20.8, 23.1, 22.0]

    average = calculate_average(temperatures)

    print(f"Average temperature: {average:.2f} Â°C")

    if average > 22:
        print("Temperature is high")
    else:
        print("Temperature is normal")


if __name__ == "__main__":
    main()
