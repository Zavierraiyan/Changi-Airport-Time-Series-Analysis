
library(ggplot2)
library(ggfortify)
library(tseries)
library(forecast)
library(TSA)
library(TSstudio)
library(zoo)
library(lmtest)
library(fpp2)
library(knitr)
library(dplyr)


data <- read.table("C:/Users/Lenovo/Documents/Kuliah/Semester 4/Metper/UAS PROJECT/total-passenger-arrival-2009-2019.csv", sep = ",", header = TRUE)
View(data)

# Konversi kolom 'month' menjadi objek 'yearmon'
data <- data %>%
  mutate(month = as.yearmon(month, "%Y-%m"))
data
# Buat data frame dengan kolom passanger dan month
df <- data %>%
  rename(passenger = value)

# Memeriksa tipe data dari setiap kolom
str(df)
class(df)
class(df$passenger)
class(df$month)
sapply(df, class)

dim(df)


sapply(df, function(x) sum(is.na(x)))

summary(df)

ggplot(df, aes(x = month, y = passenger)) + 
  geom_line() + 
  geom_smooth(method = "lm") + 
  labs(x = "Waktu (Bulan)", y = "Jumlah Penumpang", 
       title = "Jumlah Penumpang Pesawat Bulanan dari Tahun 2009 sampai 2019")

boxplot(passenger ~ format(month, "%b"), data = df, 
        xlab = "Waktu (Bulan)", ylab = "Jumlah Penumpang",
        main = "Jumlah Penumpang Pesawat Bulanan dari Tahun 2009-2019",
        las = 3) # las = 3 untuk memutar label sumbu x agar lebih mudah dibaca

#dari boxplot penumpang paling banyak di december

ggplot(df, aes(x = month, y = log(passenger))) +
  geom_line() +
  labs(x = "Waktu (Bulan)", y = expression("ln(Y"[t]*")"),
       title = expression("Time Plot ln(Y"[t]*")"))
#ada seasonality


# Membagi data menjadi train (2009-2017) dan test (2018-2019)
train <- df %>% filter(month < as.yearmon("2018-01"))
test <- df %>% filter(month >= as.yearmon("2018-01"))

# Memvisualisasikan data train dan test
ggplot() +
  geom_line(data = train, aes(x = month, y = passenger), color = "blue") +
  geom_line(data = test, aes(x = month, y = passenger), color = "red") +
  labs(x = "Waktu (Bulan)", y = "Jumlah Penumpang", 
       title = "Train (Biru) dan Test (Merah) Data")

# Mengonversi data frame menjadi objek time series
train_ts <- ts(train$passenger, start = c(2009, 1), frequency = 12)
test_ts <- ts(test$passenger, start = c(2018, 1), frequency = 12)

# Melakukan dekomposisi pada train set
decomposed <- decompose(train_ts, type = "multiplicative")

# Plot hasil dekomposisi
plot(decomposed)

# Plot logaritma natural dari kolom data frame
ggplot(train, aes(x = month, y = log(passenger))) +
  geom_line() +
  labs(x = "Waktu (Bulan)", y = expression("ln(Y"[t]*")"),
       title = expression("Time Plot ln(Y"[t]*")"))

kpss.test(train_ts)
kpss.test(diff(log(train_ts), lag = 1))
autoplot(diff(log(train_ts), lag = 1)) + labs(x = "Waktu (Bulan)", y = expression("Y"[t]),
                                           title = expression("Time Plot Y"[t]))

plot(diff(log(train_ts), lag = 1), type = 'l', ylab = 'Difference dari ln(Yt)')
points(diff(log(train_ts), lag = 1), x = time(diff(log(train_ts), lag = 1)),
       pch = as.vector(season(diff(log(train_ts), lag = 1))))

plot(diff(diff(log(train_ts)), lag = 12), type = 'l',
     ylab = 'Differencing Seasonal & Pertama dari ln(Yt)')
points(diff(diff(log(train_ts)), lag = 12), x = time(diff(diff(log(train_ts)), lag = 12)),
       pch = as.vector(season(diff(diff(log(train_ts)), lag = 12))))

ggtsdisplay(diff(diff(log(train_ts), lag = 12)))

# EACF untuk menentukan orde model ARIMA
eacf(diff(diff(log(train_ts), lag = 12)))

# Model 1: SARIMA(2, 1, 0)(0, 1, 1)[12] dengan lambda = 0
model1 <- Arima(train_ts, order = c(2, 1, 0), seasonal = c(0, 1, 1), lambda = 0)
summary(model1)

# Model 2: SARIMA(0, 1, 1)(0, 1, 1)[12] dengan lambda = 0
model2 <- Arima(train_ts, order = c(0, 1, 1), seasonal = c(0, 1, 1), lambda = 0)
summary(model2)

# Model 3: SARIMA(3, 1, 0)(0, 1, 1)[12] dengan lambda = 0
model3 <- Arima(train_ts, order = c(3, 1, 0), seasonal = c(0, 1, 1), lambda = 0)
summary(model3)

# Model 4: SARIMA(4, 1, 0)(0, 1, 1)[12] dengan lambda = 0
model4 <- Arima(train_ts, order = c(4, 1, 0), seasonal = c(0, 1, 1), lambda = 0)
summary(model4)

# Model 5: SARIMA(5, 1, 0)(0, 1, 1)[12] dengan lambda = 0
model5 <- Arima(train_ts, order = c(5, 1, 0), seasonal = c(0, 1, 1), lambda = 0)
summary(model5)

# Membandingkan model
AIC(model1, model2, model3, model4, model5)
BIC(model1, model2, model3, model4, model5)

#Model terbaik berdasarkan AIC dan BIC adalah model1 SARIMA(2, 1, 0)(0, 1, 1)[12].
coeftest(model1)

ggtsdisplay(residuals(model1))
#standardize residual sudah acak
#acf residual sudah signifikan
#pacf residual sudah signifikan

#Uji ljung box
Box.test(residuals(model1), lag = 12, type = "Ljung-Box")

#sudah signifikan, residual independen

#cek normalitas residual
hist(residuals(model1), xlab = 'Residuals')
qqnorm(residuals(model1))
qqline(residuals(model1))


#uji shapiro
shapiro.test(residuals(model1))
#H0 normal, H1 tidak normal
#p-value > 0.05, data berdistribusi normal
#model sudah cukup sesuai

#Forecasting
autoplot(cbind(train_ts, model1$fitted))
#plotnya berimpit sudah cukup bagus

#forecasting untuk data tes
m_test <- Arima(test_ts, model = model1)
accuracy(m_test)
#nilai MAPE < 10, forecastingnya akurat

autoplot(cbind(test_ts, m_test$fitted))
#plotnya berimpit, modelnya akurat

forecast <- forecast(model1, level = c(95), h = 60)
autoplot(forecast)
