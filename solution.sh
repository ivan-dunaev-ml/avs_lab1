#!/bin/bash

mkdir -p claude_monet/kitchen/hot_station
mkdir -p claude_monet/kitchen/cold_station
mkdir -p claude_monet/freezer
mkdir -p claude_monet/pantry
mkdir -p claude_monet/chef_office
mkdir -p claude_monet/staff_room

cat << 'DATA' > claude_monet/kitchen/hot_station/senya_inventory
Говядина для фирменного блюда получена
Сеня проверил мясо перед сменой
Одна упаковка колбасок оставлена на завтра
DATA

cat << 'DATA' > claude_monet/kitchen/hot_station/meat_order
Телятина для шефа
Фарш для котлет
Курица для банкета
Заказ должен принять Сеня
DATA

cat << 'DATA' > claude_monet/kitchen/cold_station/fedya_inventory
Сибас доставлен утром
Федя проверил рыбный холодильник
Дорадо осталось четыре штуки
DATA

cat << 'DATA' > claude_monet/kitchen/cold_station/fish_order
Лосось для холодной закуски
Тунец для специального заказа
Рыбные продукты передать Феде
DATA

cat << 'DATA' > claude_monet/freezer/reserve_list
Две утки для блюда Баринова
Коробка замороженных овощей
Запас мяса для большой компании
DATA

cat << 'DATA' > claude_monet/pantry/missing_products
Пропала упаковка дорогих колбасок
Не найден сыр из новой поставки
Сеня и Федя обещали всё объяснить
Баринов требует отчёт до открытия
DATA

cat << 'DATA' > claude_monet/chef_office/barinov_report
Сеня снова устроил розыгрыш на кухне
Федя помог спрятать продукты
Лёва должен проверить оба цеха
Шеф ждёт объяснительные после смены
DATA

cat << 'DATA' > claude_monet/staff_room/prank_plan
Переставить коробки в кладовой
Сказать Лёве что поставку отменили
Успеть всё вернуть до прихода Баринова
DATA

cat << 'DATA' > claude_monet/staff_room/leva_warning
Лёва заметил беспорядок в кладовой
Записи с кухни переданы шефу
Сеня и Федя останутся после смены
DATA

cat << 'DATA' > evening_incident
Вечерняя смена началась спокойно
На кухне обнаружилась пропажа продуктов
Баринов вызвал Сеню и Федю в кабинет
DATA

chmod 750 claude_monet/kitchen
chmod 640 claude_monet/kitchen/hot_station/senya_inventory
chmod 750 claude_monet/kitchen/cold_station
chmod 644 claude_monet/kitchen/cold_station/fish_order
chmod 600 claude_monet/freezer/reserve_list
chmod 750 claude_monet/pantry
chmod 710 claude_monet/chef_office
chmod 600 claude_monet/staff_room/prank_plan
chmod 644 evening_incident

chmod u=rwx,g=rx,o=rx claude_monet
chmod u=rwx,g=rwx,o= claude_monet/kitchen/hot_station
chmod u=rw,g=r,o=r claude_monet/kitchen/hot_station/meat_order
chmod u=rw,g=r,o= claude_monet/kitchen/cold_station/fedya_inventory
chmod u=rwx,g=rx,o= claude_monet/freezer
chmod u=rw,g=r,o= claude_monet/pantry/missing_products
chmod u=r,g=r,o= claude_monet/chef_office/barinov_report
chmod u=rwx,g=rx,o= claude_monet/staff_room
chmod u=r,g=r,o= claude_monet/staff_room/leva_warning

cp claude_monet/chef_office/barinov_report claude_monet/staff_room/shift_order
cp -r claude_monet/kitchen/cold_station claude_monet/staff_room/cold_backup
ln -s ../pantry/missing_products claude_monet/chef_office/product_loss
ln -s claude_monet/kitchen kitchen_work
ln evening_incident claude_monet/kitchen/incident_copy
cat claude_monet/kitchen/hot_station/senya_inventory claude_monet/kitchen/cold_station/fedya_inventory > claude_monet/kitchen/total_inventory
cat claude_monet/staff_room/leva_warning >> evening_incident
mv claude_monet/staff_room/prank_plan claude_monet/chef_office/senya_explanation

ls -lR | grep '^-' | grep -v '_copy$' | sort -k 5 -n | tail -n 4
grep -r -h -i -E 'сеня|федя' . | grep -v 'Баринов' | sort | head -n 6
grep -r -l -i 'рыб' claude_monet/kitchen/cold_station claude_monet/staff_room/cold_backup | wc -l
tail -n 2 -q claude_monet/kitchen/hot_station/*_inventory claude_monet/kitchen/cold_station/*_inventory | grep -i -E 'проверил|оста' | sort -r
grep -v -E 'Сеня|Федя' claude_monet/kitchen/total_inventory | sort -r | head -n 3 | wc -w
ls -lR | grep '^l' | sort -k 9 -r
grep -h -i -E 'кух|шеф' claude_monet/chef_office/barinov_report claude_monet/staff_room/shift_order claude_monet/staff_room/leva_warning | grep -v 'после' | sort -r | wc -w

rm claude_monet/chef_office/barinov_report
rm claude_monet/chef_office/product_loss
rm kitchen_work
rm evening_incident
rm claude_monet/kitchen/incident_copy
rm claude_monet/freezer/reserve_list
rmdir claude_monet/freezer
rm -r claude_monet/staff_room/cold_backup
