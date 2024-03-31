/*
  Warnings:

  - Added the required column `prix` to the `prix` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "prix" ADD COLUMN     "prix" DOUBLE PRECISION NOT NULL;
