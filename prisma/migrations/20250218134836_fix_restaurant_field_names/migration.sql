/*
  Warnings:

  - The values [PEDING,IN_PREPARION] on the enum `OrderStatus` will be removed. If these variants are still used in the database, this will fail.
  - The `ingredients` column on the `Product` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `nome` on the `Restaurant` table. All the data in the column will be lost.
  - Added the required column `name` to the `Restaurant` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "OrderStatus_new" AS ENUM ('PENDING', 'IN_PREPARATION', 'FINISHED');
ALTER TABLE "Order" ALTER COLUMN "status" TYPE "OrderStatus_new" USING ("status"::text::"OrderStatus_new");
ALTER TYPE "OrderStatus" RENAME TO "OrderStatus_old";
ALTER TYPE "OrderStatus_new" RENAME TO "OrderStatus";
DROP TYPE "OrderStatus_old";
COMMIT;

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "ingredients",
ADD COLUMN     "ingredients" TEXT[];

-- AlterTable
ALTER TABLE "Restaurant" DROP COLUMN "nome",
ADD COLUMN     "name" TEXT NOT NULL;
