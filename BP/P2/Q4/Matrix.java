import java.text.DecimalFormat;
import java.util.Random;

class Matrix {
    private int rows;
    private int columns;
    private double[][] values;

    public Matrix(double[][] values) {
         this.values = values;
         this.rows = values.length;
         this.columns = values[0].length;
     }

    public Matrix(int rows, int columns) {
        this.rows = rows;
        this.columns = columns;
        this.values = new double[rows][columns];
    }

    public Matrix scalarMultiplication(double scalar) {
        Matrix result = new Matrix(this.rows, this.columns);
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                result.values[i][j] = this.values[i][j] * scalar;
            }
        }
        return result;
    }

    public Matrix transposed() {
        Matrix transposed = new Matrix(this.columns, this.rows);
        for (int i = 0; i < this.columns; i++) {
            for (int j = 0; j < this.rows; j++) {
                transposed.values[i][j] = this.values[j][i];
            }
        }
        return transposed;
    }

    public Matrix matrixMultiplication(Matrix matrix) throws MatrixMultiplicationException {
        if (this.columns != matrix.getRows()) {
            throw new MatrixMultiplicationException();
        }
        int n = this.rows;
        int m = matrix.rows;
        int p = matrix.columns;
        Matrix result = new Matrix(n, p);
        double sum = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < p; j++) {
                for (int k = 0; k < m; k++) {
                    sum += this.values[i][k] * matrix.values[k][j];
                }
                result.values[i][j] = sum;
                sum = 0;
            }
        }
        return result;

    }

    public VectorB matrixMultiplyVector(VectorB vector) throws MatrixMultiplyVectorException {
        if (this.columns != vector.getRows()) throw new MatrixMultiplyVectorException();
        VectorB result = new VectorB(this.rows);

        for (int i = 0; i < this.rows; i++) {
            for (int j = 0; j < this.columns; j++) {
                result.getValues()[i] += this.values[i][j] * vector.getValues()[j];
            }
        }
        return result;
    }

    public double eigenValue() throws MatrixMultiplyVectorException {
        VectorB temp = new VectorB(this.rows);
        int n = this.rows;
        VectorB randomVector = new VectorB(n);
        Random r = new Random();
        for (int i = 0; i < n; i++) {
            randomVector.getValues()[i] = r.nextDouble();
        }
        temp = matrixMultiplyVector(randomVector);

        for (int i = 0; i < 1000; i++) {
            int maxIndex = temp.findGreatestIndex();
            temp = temp.divi(temp.getValues()[maxIndex]);
            temp = matrixMultiplyVector(temp);
        }
        int maxIndex = temp.findGreatestIndex();
        return temp.getValues()[maxIndex];
    }

    public VectorB eigenVector() throws MatrixMultiplyVectorException {
        VectorB temp = new VectorB(this.rows);
        int n = this.rows;
        VectorB randomVector = new VectorB(n);
        Random r = new Random();
        for (int i = 0; i < n; i++) {
            randomVector.getValues()[i] = r.nextDouble();
        }
        temp = matrixMultiplyVector(randomVector);

        for (int i = 0; i < 1000; i++) {
            int maxIndex = temp.findGreatestIndex();
//            temp = temp.normal();
            temp = temp.divi(temp.getValues()[maxIndex]);
            temp = matrixMultiplyVector(temp);
        }
//        int maxIndex = temp.findGreatestIndex();
        return temp;
    }

    public Matrix sum(Matrix matrix) throws SumOfMatrixException {
        if (this.rows!=matrix.getRows() || this.columns!=matrix.getColumns()) throw new SumOfMatrixException();
        Matrix result = new Matrix(this.rows, this.columns);
        for (int i = 0; i < this.rows; i++) {
            for (int j = 0; j < this.columns; j++) {
                result.values[i][j] = this.values[i][j] + matrix.values[i][j];
            }
        }
        return result;
    }

    public void printMatrix() {
        DecimalFormat df = new DecimalFormat("0.#####");
        for (int i = 0; i < this.rows; i++) {
            for (int j = 0; j < this.columns; j++) {
                System.out.print(df.format(this.values[i][j]) + " ");
            }
            System.out.println();
        }
    }

    public int getRows() {
        return rows;
    }

    public int getColumns() {
        return columns;
    }

    public double[][] getValues() {
        return values;
    }



    public void setRows(int rows) {
        this.rows = rows;
    }

    public void setColumns(int columns) {
        this.columns = columns;
    }

    public void setValues(double[][] values) {
        this.values = values;
    }
}