using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Curso
{
    public class Employee
    {
        public string Name { get; set; }
        public int Hours { get; set; }
        public double ValuePerHour { get; set; }

        public Employee()
        {

        }

        public Employee(string name, int hours, double valuePerHour)
        {
            Name = name;
            Hours = hours;
            valuePerHour = valuePerHour;
        }


        public virtual double Payment()
        {
            return Hours * ValuePerHour;
        }

    }
}